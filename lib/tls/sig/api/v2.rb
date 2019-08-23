require "tls/sig/api/v2/version"

require 'json'
# require 'rest-client'
require 'base64'
require 'openssl'
require 'digest/md5'
require 'uri'
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
              "TLS.identifier": identifier.to_s,
              "TLS.sdkappid": sdkappid.to_s,
              "TLS.expire": expire.to_s,
              "TLS.time": currTime.to_s
            }
            base64UserBuf = nil
            if userbuf != nil 
              # base64UserBuf = new BASE64Encoder().encode(userbuf);
              base64UserBuf = Base64.encode64(userbuf)
              sigDoc["TLS.userbuf"] = base64UserBuf
            end
            sig = hmacsha256(identifier, currTime, expire, base64UserBuf);
            if sig == ""
              return "";
            end
            
            sigDoc["TLS.sig"] = sig
            
            # todo
            # var compressed = zlib.deflateSync(newBuffer(JSON.stringify(sigDoc))).toString('base64');
            # return base64url.escape(compressed);

            compressed = Base64.encode64(sigDoc.to_json)
            URI.escape(compressed)
          end

          protected

          def hmacsha256(  identifier,   currTime,   expire,   base64Userbuf)
            contentToBeSigned = "TLS.identifier:" + identifier.to_s + "\n"
               + "TLS.sdkappid:" + sdkappid.to_s + "\n"
               + "TLS.time:" + currTime.to_s + "\n"
               + "TLS.expire:" + expire.to_s + "\n";
           if base64Userbuf != nil 
               contentToBeSigned += "TLS.userbuf:" + base64Userbuf + "\n";
           end

           key = "key"
           contentToBeSigned = "aaa"
           byteKey = key.encode('utf-8')
           data = contentToBeSigned.encode('utf-8')
           res = OpenSSL::HMAC.digest("sha256", byteKey, data)
           res = Base64.encode64(res)
           res
         end

        end
      end
    end
  end
end
