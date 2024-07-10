# frozen_string_literal: true
require "digest"
require "openssl"

class Hash
  include Funcml

  def _sha1sum(mutations)
    self.fetch(:_sha1sum).then do |value|
      return Digest::SHA1.hexdigest(value.mutate(mutations))
    end
  end

  def _sha256sum(mutations)
    self.fetch(:_sha256sum).then do |value|
      return Digest::SHA256.hexdigest(value.mutate(mutations))
    end
  end

  # source https://gist.github.com/wteuber/5318013
  def _encryptAES(mutations)
    self.fetch(:_encryptAES).then do |blk|
      case blk
      in {data: data, encryptionKey: encryption_key}
        cipher = OpenSSL::Cipher.new("aes-256-cbc").encrypt
        cipher.key = Digest::MD5.hexdigest(encryption_key.mutate(mutations))
        s = cipher.update(data.mutate(mutations)) + cipher.final
        s.unpack('H*')[0].upcase
      else
        raise  MissingEncryptionKeyException, "encryptionKey field missing in #{self.to_s}"
      end
    end
  end

  # source https://gist.github.com/wteuber/5318013
  def _decryptAES(mutations)
    self.fetch(:_decryptAES).then do |blk|
      case blk
      in {data: data, encryptionKey: encryption_key}
        cipher = OpenSSL::Cipher.new("aes-256-cbc").decrypt
        cipher.key = Digest::MD5.hexdigest(encryption_key.mutate(mutations))
        s = [data.mutate(mutations)].pack('H*').unpack('C*').pack('c*')
        cipher.update(s) + cipher.final
      else
        raise  MissingEncryptionKeyException, "encryptionKey field missing in #{self.to_s}"
      end
    end
  end
end