
group "rvm" do
  gid 1002
  members [node.main_user]
end

pkg_path = "/root/rpm.dpkg"

when "i686"
  url = "https://s3.amazonaws.com/tanga/rvm_1.0.0.0.1_i386.deb"
  sha = "874541e7f143d1a4e15594b8b772b4c808401697027cc3410eb23160f9427eb1"
when "x86_64"
  url = ""
  sha = ""
end
