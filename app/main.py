import geoip2.database
from fastapi import FastAPI, Path, HTTPException
from geoip2.errors import AddressNotFoundError

app = FastAPI()
reader = geoip2.database.Reader("GeoLite2-City.mmdb")


@app.api_route("/health", methods=["GET", "HEAD"])
def get_health():
    return "ok"


@app.get("/ips/{ip}")
def get_ip(ip: str = Path(pattern=r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")):
    try:
        info = reader.city(ip)
    except AddressNotFoundError:
        raise HTTPException(status_code=400, detail="Invalid IP address")

    return {
        "latitude": info.location.latitude,
        "longitude": info.location.longitude,
        "country": info.country.name,
        "city": info.city.name,
        "ip": info.traits.ip_address,
    }
