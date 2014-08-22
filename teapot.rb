
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0.0"

define_target "variant-debug" do |target|
	# We should choose debug by default, unless release is specified explicity:
	target.priority = 10
	
	target.provides "Variant/debug" do
		default variant "debug"
		
		append buildflags %W{-O0 -g -Wall -Wmissing-prototypes}
		append linkflags %W{-g}
		
		define Rule, "log.files" do
			input :files
		
			apply do |arguments|
				puts "Input files: #{arguments[:files].to_a.inspect}"
			end
		end
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
