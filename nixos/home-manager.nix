{
  inputs,
  vars,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager.backup";

    extraSpecialArgs = {inherit inputs vars;};
    users."${vars.username}" = import ../home;
  };
}
