
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.7.0"

define_target "variant-debug" do |target|
	target.provides "Variant/debug" do
		default variant "debug"
		
		append buildflags %W{-O0 -g -Wall -Wmissing-prototypes}
		append linkflags %W{-g}
	end
	
	target.provides :variant => "Variant/debug"
end

define_target "variant-release" do |target|
	target.provides "Variant/release" do
		default variant "release"
		
		append buildflags %W{-O3 -DNDEBUG}
	end
	
	target.provides :variant => "Variant/release"
end
