require 'formula'

class HttpdModFcgid < Formula
	homepage 'http://httpd.apache.org/mod_fcgid'
	url 'http://www.apache.org/dist/httpd/mod_fcgid/mod_fcgid-2.3.9.tar.bz2'
	sha1 '99d6b24f3f83a3a83d1d93d12a0d5992e3fa7851'
	version '2.3.9'

	depends_on 'httpd24'

	def install

		system './configure.apxs'
		system 'make'
		system 'make install'
	end

end