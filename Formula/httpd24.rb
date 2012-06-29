require 'formula'

class Httpd24 < Formula
	homepage 'http://httpd.apache.org'
	url 'http://www.apache.org/dist/httpd/httpd-2.4.2.tar.bz2'
	sha1 '8d391db515edfb6623c0c7c6ce5c1b2e1f7c64c2'
	version '2.4.2'

	skip_clean ['bin', 'sbin']

	depends_on 'pcre'

	def options
	 [
	 	['--with-ssl', 'Include SSL support'],
	 	['--with-lua', 'Include Lua support'],
	 	['--with-ldap', 'Include LDAP support']
	 ]
	end

	def install
		args = [
			"--disable-debug",
			"--disable-dependency-tracking",
			"--prefix=#{prefix}",
			"--mandir=#{man}",
			"--enable-layout=GNU",
			"--with-mpm=prefork"
		]

		if ARGV.include? '--with-ssl'
			args << "--enable-ssl"
			args << "--with-ssl=/usr"
		end

		if ARGV.include? '--with-lua'
			args << "--with-lua"
		end

		if ARGV.include? '--with-ldap'
			args << "--with-ldap"
		end

		system "./configure", *args
		system "make"
		system "make install"

		(prefix+'com.apache.httpd.plist').write startup_plist
		(prefix+'com.apache.httpd.plist').chmod 0644
	end

	def startup_plist; <<-EOPLIST.undent
		<?xml version="1.0" encoding="UTF-8"?>
	    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	    <plist version="1.0">
	    <dict>
	      <key>Label</key>
	      <string>com.apache.httpd</string>
	      <key>ProgramArguments</key>
	      <array>
	        <string>#{sbin}/apachectl</string>
	        <string>start</string>
	      </array>
	      <key>RunAtLoad</key>
	      <true/>
	    </dict>
	    </plist>
    	EOPLIST
    end
end