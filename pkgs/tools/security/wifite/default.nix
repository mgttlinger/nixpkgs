{ stdenv, pythonPackages, fetchFromGitHub, pkgs }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "wifite2";
  version = "2.00";

  src = fetchFromGitHub {
    owner = "derv82";
    repo = "wifite2";
    rev = "aa75970ad1d961dd6e638a387c117f755e815086";
    sha256 = "036l99ds4x4kp24v84qsi6656z1l1wizz308i6kj83r91wkp42px";
    fetchSubmodules = true;
  };

  propagatedBuildInputs = with pkgs; [ python27Full aircrackng wirelesstools iw ethtool cowpatty ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./ $out
    ln -s $out/Wifite.py $out/bin/wifite2
  '';
  checkPhase = "runtests.sh";

  meta = with stdenv.lib; {
    description = "Python script for auditing wireless networks";
    homepage = https://github.com/derv82/wifite2;
    license = licenses.gplv2;
    maintainers = with maintainers; [ mgttlinger ];
  };
}
