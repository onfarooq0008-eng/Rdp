# Koyeb WebUI RDP

This is a lightweight browser desktop for Koyeb.

## What it is
It is a **browser-based VNC desktop** served through **noVNC**.
It is not classic Microsoft RDP, but it works from any web browser.

## Included
- Openbox desktop
- Xvfb virtual display
- x11vnc server
- noVNC web access
- xterm
- pcmanfm
- Firefox ESR

## Port
Expose port **8080** on Koyeb.

## Build and run
```bash
docker build -t koyeb-webui-rdp .
docker run -p 8080:8080 koyeb-webui-rdp
```

## Use on Koyeb
- Deploy this folder as a Docker app
- Set the service port to **8080**
- Open the app URL in your browser

## Notes
If Firefox is too heavy for your 512 MB instance, remove it from the Dockerfile and use only xterm + pcmanfm.
