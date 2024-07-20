import http from "k6/http";
import { sleep } from "k6";

const ips = [
    "159.248.76.106",
    "151.206.169.103",
    "182.186.231.101",
    "147.242.126.214",
    "141.33.143.182",
    "171.34.144.74",
    "150.192.33.1",
    "161.4.159.92",
    "191.221.138.193",
    "154.155.145.186"
];

export const options = {
    vus: 100,
    duration: "30s",
};

export default function() {
    const ip = ips[Math.round(Math.random() * (ips.length - 1))];
    http.get(`http://localhost:8080/ips/${ip}`);
    sleep(1);
}
