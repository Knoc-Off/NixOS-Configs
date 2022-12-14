{config, libs, pkgs, ...}:
let
  name = "DE-SC";
in
{
  networking.wg-quick.interfaces = {
    ${name} = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKey = "0PWR8WzveQ7gzWfGtpQwiD8XF/aCwrjC0JjhVBu37GY=";
      mtu = 1200;
      peers = [
        {
          publicKey = "9xUSjs4KYUv0ySbhrYjwN/49TpHfmIcI/2KdGkOEGz0=";
          #presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "185.159.156.98:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
