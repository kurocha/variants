
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.5"

define_package "variant-debug" do |package|
	package.provides "Variant/debug" do
		default variant "debug"
		
		append buildflags %W{-O0 -g -Wall -Wmissing-prototypes}
		append linkflags %W{-g}
	end
	
	package.provides :variant => "Variant/debug"
end

define_package "variant-release" do |package|
	package.provides "Variant/release" do
		default variant "release"
		append buildflags %W{-O3 -DNDEBUG}
	end
	
	package.provides :variant => "Variant/release"
end
