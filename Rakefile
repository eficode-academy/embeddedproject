require 'rake/clean'

CLEAN.include('*.o')
CLOBBER.include('*.exe')

APPLICATION  = 'catch.exe'

WARNINGS     = "-Wall -Wextra \
                -Warray-bounds \
                -Weffc++ \
                -Wno-parentheses \
                -Wpedantic \
                -Wwrite-strings"

Dir.chdir "omed-app"

puts("Project files moved into a single sub-directory.")
puts("Update this Rakefile properly to reflect the move.");
# abort("Exiting...")

INC_FILES = Rake::FileList['inc/*.h']
SRC_FILES = Rake::FileList["src/*.cc","tst/*.cc"]
OBJ_FILES = SRC_FILES.ext(".o")
TST_OBJ_FILES = SRC_FILES.ext(".o").exclude("src/main.o")

desc "Build the catch executable"
file APPLICATION => TST_OBJ_FILES do |task|
    sh "g++ #{TST_OBJ_FILES} -o #{task.name}"
end

rule '.o' => '.cc' do |task|
    sh "g++ -std=c++11 #{WARNINGS} -I inc -c -o #{task.name} #{task.source}"
end

desc "Run catch tests"
task :default => APPLICATION do
    begin
        sh "./#{APPLICATION}"
    rescue => e
    end
end
