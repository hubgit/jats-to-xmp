# jats-to-xmp

Convert JATS XML to XMP

## Usage

    xsltproc --stringparam now `date "+%Y-%m-%dT%H:%M:%SZ"` jats-to-xmp.xsl example/input.jats.xml

    exiftool -tagsfromfile example/output.xmp.xml -all:all article.pdf
    
    jhove -c conf/jhove.conf -m pdf-hul -k article.pdf
    
    #./jhove2.sh article.pdf
    
    cat example/output.xmp.xml | grep -v xmpmeta | cwm --rdf --ntriples
