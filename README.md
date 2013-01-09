# jats-to-xmp

Convert JATS XML to XMP

## Usage

    xsltproc --stringparam now `date "+%Y-%m-%dT%H:%M:%SZ"` jats-to-xmp.xsl example/input.jats.xml