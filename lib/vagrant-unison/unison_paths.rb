module VagrantPlugins
  module Unison
    class UnisonPaths
      def initialize(env, machine)
        @env = env
        @machine = machine
      end

      def guest
        @guest ||= @machine.config.sync.guest_folder.tap do |folder|
          fail I18n.t("vagrant_unison.config.guest_folder_required") if folder.to_s.empty?
        end
      end

      def host
        @host ||= begin
          folder = @machine.config.sync.host_folder
          fail I18n.t("vagrant_unison.config.host_folder_required") if folder.to_s.empty?
          path = File.expand_path(folder, @env.root_path)

          # Make sure there is a trailing slash on the host path to
          # avoid creating an additional directory with rsync
          path = "#{path}/" if path !~ /\/$/
        end
      end
    end
  end
end
