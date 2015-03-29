class KitchenAppbundleUpdater
  class Helpers
    def self.load_file(file, is_powershell)
        src_file = File.join(
          File.dirname(__FILE__),
          %w[.. .. support],
          file + (is_powershell ? ".ps1" : ".sh")
        )
        IO.read(src_file)
      end
  end
end
