const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const php = require('locutus/php');

var Tools = {
    dateFormat(){
        return 'YYYY-MM-DD H:mm:ss';
    },

	isDomain: (domain) => {
      	var re = new RegExp(/^((?:(?:(?:\w[\.\-\+]?)*)\w)+)((?:(?:(?:\w[\.\-\+]?){0,62})\w)+)\.(\w{2,6})$/);
      	return domain.match(re);
    },

    verifyJwtToken: (token, secretKey) => {
        return new Promise((resolve, reject) => {
            jwt.verify(token, secretKey, (err, decoded) => {
                if (err) {
                    return reject(err);
                }
                resolve(decoded);
            });
        });
    },

    async passwordGenerator(password){
        const salt = await bcrypt.genSalt(6);
        const hashed = await bcrypt.hash(password, salt);
        return hashed;
    },

    is_serialized( $data, $strict = true ) {
        // if it isn't a string, it isn't serialized.
        if ( ! php.var.is_string( $data ) ) {
            return false;
        }
        $data = php.strings.trim( $data );
        if ( 'N;' == $data ) {
            return true;
        }
        if ( php.strings.strlen( $data ) < 4 ) {
            return false;
        }
        if ( ':' !== $data[1] ) {
            return false;
        }
        if ( $strict ) {
            let $lastc = php.strings.substr( $data, -1 );
            if ( ';' !== $lastc && '}' !== $lastc ) {
                return false;
            }
        } else {
            let $semicolon = php.strings.strpos( $data, ';' );
            let $brace     = php.strings.strpos( $data, '}' );
            // Either ; or } must exist.
            if ( false === $semicolon && false === $brace )
                return false;
            // But neither must be in the first X characters.
            if ( false !== $semicolon && $semicolon < 3 )
                return false;
            if ( false !== $brace && $brace < 4 )
                return false;
        }
        let $token = $data[0];
        let $_return = false;
        let regex = null;
        switch ( $token ) {
            case 's' :
                if ( $strict ) {
                    if ( '"' !== php.strings.substr( $data, -2, 1 ) ) {
                        $_return = false;
                    }
                } else if ( false === php.strings.strpos( $data, '"' ) ) {
                    $_return = false;
                }
                break;
                // or else fall through
            case 'a' :
            case 'O' :
                regex = $token === 'a'? /^a:[0-9]+:/s: /^O:[0-9]+:/s;
                $_return = regex.exec($data) !== null? true: false;
                break;
            case 'b' :
            case 'i' :
            case 'd' :
                if($strict){
                    if($token === 'b') regex = /^b:[0-9.E-]+;$/;
                    if($token === 'i') regex = /^i:[0-9.E-]+;$/;
                    if($token === 'd') regex = /^d:[0-9.E-]+;$/;
                }else{
                    if($token === 'b') regex = /^b:[0-9.E-]+;/;
                    if($token === 'i') regex = /^i:[0-9.E-]+;/;
                    if($token === 'd') regex = /^d:[0-9.E-]+;/;
                }
                $_return = regex.exec($data) !== null? true: false;
                break;
        }
        return $_return;
    },

    maybe_unserialize( $original ) {
        if ( this.is_serialized( $original ) ) // don't attempt to unserialize data that wasn't serialized going in
            return php.var.unserialize( $original );
        return $original;
    },

    maybe_serialize( $data ) {
        if ( php.var.is_array( $data ) || php.var.is_object( $data ) )
            return php.var.serialize( $data );

        if ( this.is_serialized( $data, false ) )
            return php.var.serialize( $data );

        return $data;
    }
}

module.exports = Tools;
