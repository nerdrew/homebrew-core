class RancherCli < Formula
  desc "The Rancher CLI is a unified tool to manage your Rancher server"
  homepage "https://github.com/rancher/cli"
  url "https://github.com/rancher/cli/archive/v2.0.4.tar.gz"
  sha256 "a902d54717bb9c4152a7400b78b9455bfa6ebb5ec51906c63f26b91b5b51d29c"

  bottle do
    cellar :any_skip_relocation
    sha256 "af1afea63264a1e98f606c974d733319ed7cfb735dd61ed6ac0df114cfa7994e" => :high_sierra
    sha256 "7e44d5d08413e49d9e1f53fcc8d469a8b4f908c2c4be744c86fdcc231285cb69" => :sierra
    sha256 "80d5d295f4b4ea2d4535d970cb32d0e6efbc633ca84e9121cf24b0f2ee131947" => :el_capitan
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/rancher/cli/").install Dir["*"]
    system "go", "build", "-ldflags",
           "-w -X github.com/rancher/cli/version.VERSION=#{version}",
           "-o", "#{bin}/rancher",
           "-v", "github.com/rancher/cli/"
  end

  test do
    system bin/"rancher", "help"
  end
end
