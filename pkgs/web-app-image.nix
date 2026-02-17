{
  dockerTools,
  caddy,
  web-app,
}:
dockerTools.buildLayeredImage {
  name = "web-app";
  tag = "latest";

  contents = [
    web-app
    caddy
  ];

  config = {
    Cmd = [
      "${caddy}/bin/caddy"
      "run"
      "--adapter"
      "caddyfile"
      "--config"
      "${../src/web-app/Caddyfile}"
    ];
  };

  extraCommands = ''
    mkdir -p srv
    cp -r ${web-app}/* srv/
  '';
}
