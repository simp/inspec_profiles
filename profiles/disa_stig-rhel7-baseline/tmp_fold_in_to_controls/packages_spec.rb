DISABLED_PKGS = attribute(
  'disabled_pkgs',
  default: ['dhcp'],
  description: "The list of packages that we want to ensure are not installed"
)

ENABLED_PKGS = attribute(
  'enabled_pkgs',
  default: ['tcp_wrappers'],
  description: "The list of packages that we want to ensure are not installed"
)

only_if do
  DISABLED_PKGS.any?
end

DISABLED_PKGS.each do |pkg|
  describe package(pkg) do
    it { should_not be_installed }
  end
end

only_if do
  ENABLED_PKGS.any?
end

ENABLED_PKGS.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
