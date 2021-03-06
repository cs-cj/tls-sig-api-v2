require "tls/sig/api/v2/version"
require 'json'
require 'base64'
require 'openssl'
require "zlib"
# require 'digest/md5'
require 'time'

module Tls
  module Sig
    module Api
      module V2
        # class Error < StandardError; end
        # Your code goes here...
        class Server
          attr_accessor :sdkappid, :key
    
          def initialize(sdkappid, key)
            @sdkappid = sdkappid
            @key = key
          end

        #  /**
        #   * 生成 usersig
        #   * @param identifier 用户账号
        #   * @param expire 有效期，单位秒
        #   * @returns {string} 返回的 sig 值
        #   */
          def gen_sig( identifier,  expire) 
             gen_sig_with_userbuf(identifier, expire, nil);
          end
    
          # /**
          # * 生成带 userbuf 的 usersig
          # * @param identifier  用户账号
          # * @param expire 有效期，单位秒
          # * @param userBuf 用户数据
          # * @returns {string} 返回的 sig 值
          # */
          def gen_sig_with_userbuf(  identifier,   expire,   userbuf)
            currTime = Time.now.to_i
            sigDoc = {
              "TLS.ver": "2.0",
              "TLS.identifier": identifier,
              "TLS.sdkappid": sdkappid ,
              "TLS.expire": expire ,
              "TLS.time": currTime
            }
            base64UserBuf = nil
            if userbuf != nil 
              base64UserBuf = Base64.strict_encode64(userbuf)
              sigDoc["TLS.userbuf"] = base64UserBuf
            end
            sig = hmacsha256(identifier, currTime, expire, base64UserBuf);
            if sig == ""
              return "";
            end       
            sigDoc["TLS.sig"] = sig
            json = sigDoc.to_json
            data_compressed = Zlib::Deflate.deflate(json)
            base64str = Base64.strict_encode64(data_compressed) 
            escape(base64str)
          end

          protected

          def hmacsha256(  identifier,   currTime,   expire,   base64Userbuf)
            contentToBeSigned = "TLS.identifier:#{identifier}\n" + "TLS.sdkappid:#{sdkappid}\n" + "TLS.time:#{currTime}\n" + "TLS.expire:#{expire}\n";
           if base64Userbuf != nil 
               contentToBeSigned += "TLS.userbuf:" + base64Userbuf + "\n";
           end
           res = OpenSSL::HMAC.digest("sha256", key, contentToBeSigned)
           res = Base64.strict_encode64(res) 
           res
         end


         def escape(str)
           str.gsub(/\+/, '*').gsub(/\//, '-').gsub(/=/, '_')
         end

        end
      end
    end
  end
end
