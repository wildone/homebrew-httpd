require 'formula'

class HttpdModFcgid < Formula
	homepage 'http://httpd.apache.org/mod_fcgid'
	url 'http://www.apache.org/dist/httpd/mod_fcgid/mod_fcgid-2.3.7.tar.bz2'
	sha1 '927c44122a28b676694727f70339853f216036b7'
	version '2.3.7'

	depends_on 'httpd24'

	def install

		system './configure.apxs'
		system 'make'
		system 'make install'
	end

end