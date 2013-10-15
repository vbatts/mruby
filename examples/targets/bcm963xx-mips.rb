
# This is the build for bcm963xx mips, using the 
# cross-compiler toolchain for the gt784wn router
# http://opensource.actiontec.com/gt784wn.html
MRuby::CrossBuild.new('mips') do |conf|
  toolchain :gcc

  # This is where their installer lands its compiler toolchain
  T_PATH = '/opt/toolchains/uclibc-crosstools-gcc-4.4.2-1/usr'

  conf.cc do |cc|
    cc.command = "#{T_PATH}/bin/mips-linux-gcc"
    cc.include_paths << ["#{T_PATH}/lib/gcc/mips-linux-uclibc/4.4.2/include",
                        "#{T_PATH}/include"]
    cc.flags << %w(-g -O2 -Wall -static -msoft-float -march=24kc)
  end
  conf.linker do |l|
    l.command = "#{T_PATH}/bin/mips-linux-ld"
    l.library_paths << ["#{T_PATH}/lib",
                        "#{T_PATH}/lib/gcc/mips-linux-uclibc/4.4.2"]
    l.flags_after_libraries << %w(-lgcc)
    l.flags << %w(-s -static -msoft-float)
    l.link_options = ["#{T_PATH}/lib/gcc/mips-linux-uclibc/4.4.2", "-lgcc"]
  end
  conf.archiver.command = "#{T_PATH}/bin/mips-linux-ar"

end

