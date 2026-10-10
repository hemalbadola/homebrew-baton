class Baton < Formula
  include Language::Python::Virtualenv

  desc "Run one large language model across several laptops on the same Wi-Fi"
  homepage "https://github.com/hemalbadola/baton"
  url "https://github.com/hemalbadola/baton/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "dfce945811ab81dc69d9c9cd0dca29aee2e558c83aa475a483e30017ba068d14"

  depends_on "python@3.12"

  # PyTorch ships its own libraries. Homebrew must not rewrite them.
  skip_clean "libexec"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Dependencies come from PyPI, as for any `pip install`. The first install
    # downloads PyTorch, which is large.
    system venv.root/"bin/python", "-m", "pip", "install", "--verbose", buildpath
    bin.install_symlink libexec/"bin/baton"
  end

  def caveats
    <<~EOS
      Run on every laptop, on the same Wi-Fi:
        baton app
    EOS
  end

  test do
    assert_match "app", shell_output("#{bin}/baton --help")
  end
end
