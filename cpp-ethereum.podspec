Pod::Spec.new do |spec|
  spec.name = "cpp-ethereum"
  spec.summary = "Ethereum C++ client"
  spec.homepage = 'http://cpp-ethereum.org/'
  spec.authors = "The Ethereum C++ Authors"
  spec.license = { type: "GPLv3", file: "LICENSE" }

  spec.version = "1.4.pre.7"
  spec.source = {
      git: 'https://github.com/cpp-ethereum-ios/cpp-ethereum.git',
      tag: "v#{spec.version}"
  }

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  # TODO: move dependencies into subspecs
  # TODO: ensure that all dependencies can be dynamically linked
  # TODO: enable bitcode on all dependencies
  # TODO: remove/ignore all compiler warnings
  # TODO: support binary versions in the podspecs

  spec.dependency 'Apple-Boost', '~> 1.6'
  spec.dependency 'Cryptopp', '~> 5.6.4.0'
  spec.dependency 'GMP-iOS', '~> 6.1'
  spec.dependency 'JsonCpp', '~> 1.7'
  spec.dependency 'leveldb', '~> 1.18'
  spec.dependency 'libjson-rpc-cpp', '~> 0.6'
  spec.dependency 'libmicrohttpd-iOS', '~> 0.9'
  spec.dependency 'miniupnp', '~> 2.0'

  spec.default_subspec = 'eth'

  spec.subspec 'eth' do |subspec|
      subspec.dependency 'cpp-ethereum/libethereum'
      subspec.dependency 'cpp-ethereum/libethcore'
      subspec.dependency 'cpp-ethereum/libevm'
      subspec.dependency 'cpp-ethereum/libethashseal'
      subspec.dependency 'cpp-ethereum/libwebthree'
      subspec.dependency 'cpp-ethereum/libweb3jsonrpc'
      subspec.dependency 'cpp-ethereum/ethminer'
      subspec.source_files = "eth/*.{cpp,h}"
      subspec.compiler_flags = '-DETH_JSONRPC'
      subspec.header_dir = 'eth'
  end

  spec.subspec 'libweb3jsonrpc' do |subspec|
      subspec.dependency 'cpp-ethereum/libwebthree'
      subspec.dependency 'cpp-ethereum/libwhisper'
      subspec.source_files = 'libweb3jsonrpc/*.{cpp,h}'
      subspec.header_dir = 'libweb3jsonrpc'
  end

  spec.subspec 'ethminer' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.dependency 'cpp-ethereum/libethcore'
      subspec.dependency 'cpp-ethereum/libethashseal'
      subspec.source_files = 'ethminer/*.{cpp,h}'
      subspec.exclude_files = 'ethminer/main.cpp'
      subspec.header_dir = 'ethminer'
  end

  spec.subspec 'libwebthree' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.dependency 'cpp-ethereum/libethcore'
      subspec.dependency 'cpp-ethereum/libwhisper'
      subspec.dependency 'cpp-ethereum/libethashseal'
      subspec.source_files = 'libwebthree/*.{cpp,h}', 'libwebthree/libexecstream/*.{cpp,h}'
      subspec.preserve_path = 'libwebthree/libexecstream/posix'
      subspec.header_dir = 'libwebthree'
      subspec.header_mappings_dir = 'libwebthree'
  end

  spec.subspec 'libwhisper' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.dependency 'cpp-ethereum/libp2p'
      subspec.source_files = 'libwhisper/*.{cpp,h}'
      subspec.header_dir = 'libwhisper'
  end

  spec.subspec 'libethashseal' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.dependency 'cpp-ethereum/libethcore'
      subspec.dependency 'cpp-ethereum/libethash'
      subspec.source_files = "libethashseal/*.{cpp,h}"
      subspec.header_dir = 'libethashseal'
  end

  spec.subspec 'libethash' do |subspec|
      subspec.source_files = "libethash/*.{c,cpp,h}"
      subspec.exclude_files = "**/*win32*"
      subspec.header_dir = 'libethash'
  end

  spec.subspec 'libethereum' do |subspec|
      subspec.dependency 'cpp-ethereum/libethereum+libethcore+libevm'
  end

  spec.subspec 'libethcore' do |subspec|
      subspec.dependency 'cpp-ethereum/libethereum+libethcore+libevm'
  end

  spec.subspec 'libevm' do |subspec|
      subspec.dependency 'cpp-ethereum/libethereum+libethcore+libevm'
  end

  # Compile libethereum, libethcore and libevm together because of circular
  # dependencies. See also https://github.com/ethereum/cpp-ethereum/issues/3091
  spec.subspec 'libethereum+libethcore+libevm' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.dependency 'cpp-ethereum/libdevcrypto'
      subspec.dependency 'cpp-ethereum/libevmcore'
      subspec.dependency 'cpp-ethereum/libp2p'
      subspec.source_files = "{libethereum,libethcore,libevm}/*.{cpp,h}"
      subspec.exclude_files = "libevm/{JitVM,SmartVM}.{cpp,h}"
      subspec.header_mappings_dir = '.'
  end

  spec.subspec 'libp2p' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.dependency 'cpp-ethereum/libdevcrypto'
      subspec.source_files = "libp2p/*.{cpp,h}"
      subspec.header_dir = 'libp2p'
  end

  spec.subspec 'libevmcore' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.source_files = 'libevmcore/*.{cpp,h}'
      subspec.header_dir = 'libevmcore'
  end

  spec.subspec 'libdevcrypto' do |subspec|
      subspec.dependency 'cpp-ethereum/libdevcore'
      subspec.dependency 'cpp-ethereum/libscrypt'
      subspec.dependency 'cpp-ethereum/json_spirit'
      subspec.source_files = "libdevcrypto/*.{cpp,h}"
      subspec.header_dir = "libdevcrypto"
  end

  spec.subspec 'libdevcore' do |subspec|
      subspec.dependency 'cpp-ethereum/buildinfo'
      subspec.source_files = "libdevcore/*.{cpp,h}"
      subspec.header_dir = "libdevcore"
  end

  spec.subspec 'libscrypt' do |subspec|
      subspec.source_files = "utils/libscrypt/*.{c,h}"
      subspec.header_dir = "libscrypt"
  end

  spec.subspec 'json_spirit' do |subspec|
      subspec.source_files = "utils/json_spirit/*.{cpp,h}"
      subspec.header_dir = "json_spirit"
  end

  spec.subspec 'buildinfo' do |subspec|
      subspec.source_files = "cpp-ethereum/BuildInfo.h"
      subspec.header_dir = "cpp-ethereum"
  end

  spec.prepare_command = <<-CMD

    # Replace main() with eth_main()
    sed -i '' 's/main(/eth_main(/g' eth/main.cpp

    # Create BuildInfo.h
    mkdir -p cpp-ethereum
    S0='s/@PROJECT_VERSION@/#{spec.version}/g'
    S1="s/@ETH_COMMIT_HASH@/$(git rev-parse v#{spec.version})/g"
    S2='s/@ETH_CLEAN_REPO@/1/g'
    S3='s/@ETH_BUILD_TYPE@/CocoaPods/g'
    S4='s/@ETH_BUILD_OS@/Darwin/g'
    S5='s/@ETH_BUILD_COMPILER@/appleclang/g'
    S6='s/@ETH_BUILD_JIT_MODE@/Interpreter/g'
    S7='s/@ETH_BUILD_PLATFORM@/Darwin\\/appleclang\\/Interpreter/g'
    S8='s/@ETH_BUILD_NUMBER@/65535/g'
    S9='s/@ETH_VERSION_SUFFIX@//g'
    sed "$S0;$S1;$S2;$S3;$S4;$S5;$S6;$S7;$S8;$S9" \
        cmake/templates/BuildInfo.h.in > cpp-ethereum/BuildInfo.h

  CMD

end
