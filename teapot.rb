
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0.0"

# Platforms
define_target "variant-generic" do |target|
	target.provides "Variant/generic" do
		default build_prefix {platforms_path + "cache/#{platform_name}-#{variant}"}
		default install_prefix {platforms_path + "#{platform_name}-#{variant}"}
	end
end

define_target "variant-debug" do |target|
	# We should choose debug by default, unless release is specified explicity:
	target.priority = 10
	
	target.provides "Variant/debug" do
		default variant "debug"
		
		append buildflags %W{-O0 -g -Wall -fno-limit-debug-info}
		append cflags %W{-Wmissing-prototypes}
		append linkflags %W{-g}
	end
	
	target.depends "Variant/generic"
	target.provides :variant => "Variant/debug"
end

define_target "variant-sanitize" do |target|
	target.provides "Variant/sanitize" do
		default variant "sanitize"
		
		append buildflags %W{-O0 -g -Wall -fno-omit-frame-pointer -fsanitize=address,undefined -DVARIANT_SANITIZE}
		append cflags %W{-Wmissing-prototypes}
		append linkflags %W{-g -fsanitize=address,undefined}
	end
	
	target.depends "Variant/generic"
	target.provides :variant => "Variant/sanitize"
end


define_target "variant-release" do |target|
	target.provides "Variant/release" do
		default variant "release"
		
		append buildflags %W{-O3 -march=native -DNDEBUG}
	end
	
	target.depends "Variant/generic"
	target.provides :variant => "Variant/release"
end

define_target "variant-release-lto" do |target|
	target.provides "Variant/release-lto" do
		default variant "release-lto"
		
		append linkflags '-fuse-ld=gold'
		append buildflags %W{-O3 -flto -march=native -DNDEBUG}
	end
	
	target.depends "Variant/generic"
	target.provides :variant => "Variant/release-lto"
end
