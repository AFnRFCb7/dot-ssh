{
    inputs = { } ;
    outputs =
        { self } :
            {
                lib =
                    { visitor } :
                        let
                            implementation =
                                configuration :
                                    {
                                        init =
                                            { pkgs , resources , self } :
                                                let
                                                    application =
                                                        pkgs.writeShellApplication
                                                            {
                                                                name = "init" ;
                                                                runtimeInputs = [ pkgs.coreutils pkgs.gettext ] ;
                                                                text =
                                                                    let
                                                                        bash =
                                                                            let
                                                                                mapper =
                                                                                    host-name : value :
                                                                                        let
                                                                                            v =
                                                                                                visitor
                                                                                                    {
                                                                                                        bool = path : value : builtins.concatStringsSep "" [ ( bash-name host-name ( builtins.elemAt path 0 ) ) "=" ( if value then "Yes" else "No" ) ] ;
                                                                                                        int = path : value : builtins.concatStringsSep "" [ ( bash-name host-name ( builtins.elemAt path 0 ) ) "=" ( builtins.toJSON value ) ] ;
                                                                                                        lambda =
                                                                                                            path : value :
                                                                                                                let
                                                                                                                    x = value { pkgs = pkgs ; resources = resources ; self = self ; } ;
                                                                                                                    in builtins.concatStringsSep "" [ ( bash-name host-name ( builtins.elemAt path 0 ) ) "=" x.directory ] ;
                                                                                                        string = path : value : builtins.concatStringsSep "" [ ( bash-name host-name ( builtins.elemAt path 0 ) ) "=" ( builtins.toJSON value) ] ;
                                                                                                    }
                                                                                                    value ;
                                                                                            in builtins.concatStringsSep "\n" ( builtins.attrValues v ) ;
                                                                                in builtins.mapAttrs mapper configuration ;
                                                                        bash-name = host-name : attribute-name : builtins.concatStringsSep "" [ "V" ( builtins.hashString "sha512" ( builtins.concatStringsSep "c80c2687f8aa97ca4b3b44626d06d366a93fa8c67de5cf52d565b17b48334603aad79b5cb3d293f54f6084df628e343f71f4704bff525c840e8435e9fa1cad27" [ host-name attribute-name ] ) ) ] ;
                                                                        dot-ssh =
                                                                            let
                                                                                mapper =
                                                                                    host-name :
                                                                                        {
                                                                                            address-family ? null ,
                                                                                            batch-mode ? null ,
                                                                                            bind-address ? null ,
                                                                                            canonical-domains ? null ,
                                                                                            canonicalize-fallback-local ? null ,
                                                                                            canonicalize-hostname ? null ,
                                                                                            check-host-ip ? null ,
                                                                                            challenge-response-authentication ? null ,
                                                                                            ciphers ? null ,
                                                                                            compression ? null ,
                                                                                            connect-timeout ? null ,
                                                                                            control-master ? null ,
                                                                                            control-path ? null ,
                                                                                            forward-agent ? null ,
                                                                                            gateway-ports ? null ,
                                                                                            gssapi-authentication ? null ,
                                                                                            gssapi-delegate-credentials ? null ,
                                                                                            gssapi-key-exchange ? null ,
                                                                                            gssapi-renewal-forces-rekey ? null ,
                                                                                            gssapi-trust-dns ? null ,
                                                                                            host ? null ,
                                                                                            hostkey-alias ? null ,
                                                                                            identities-only ? null ,
                                                                                            identity-agent ? null ,
                                                                                            identity-file ? null ,
                                                                                            ignore-unknown ? null ,
                                                                                            ip-qos ? null ,
                                                                                            kbd-interactive-authentication ? null ,
                                                                                            kbd-interactive-devices ? null ,
                                                                                            kex-algorithms ? null ,
                                                                                            local-forward ? null ,
                                                                                            log-level ? null ,
                                                                                            match ? null ,
                                                                                            no-host-authentication-for-localhost ? null ,
                                                                                            password-authentication ? null ,
                                                                                            permit-local-command ? null ,
                                                                                            permit-remote-open ? null ,
                                                                                            pkcs11-provider ? null ,
                                                                                            port ? null ,
                                                                                            preferred-authentications ? null ,
                                                                                            protocol ? null ,
                                                                                            proxy-command ? null ,
                                                                                            proxy-jump ? null ,
                                                                                            proxy-use-fdpass ? null ,
                                                                                            pubkey-accepted-key-types ? null ,
                                                                                            pubkey-authentication ? null ,
                                                                                            rekey-limit ? null ,
                                                                                            remote-forward ? null ,
                                                                                            server-alive-count-max ? null ,
                                                                                            server-alive-interval ? null ,
                                                                                            sessiontype ? null ,
                                                                                            strict-host-key-checking ? null ,
                                                                                            user ? null ,
                                                                                            user-known-hosts-file ? null
                                                                                        } @value :
                                                                                            let
                                                                                                mapper =
                                                                                                    attribute-name : attribute-value :
                                                                                                        let
                                                                                                            left-name = bash-name host-name attribute-name ;
                                                                                                            right-name = builtins.replaceStrings [ "-a" "-b" "-c" "-d" "-e" "-f" "-g" "-h" "-i" "-j" "-k" "-l" "-m" "-n" "-o" "-p" "-q" "-r" "-s" "-t" "-u" "-v" "-w" "-x" "-y" "-z" ] [ "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ] ( builtins.concatStringsSep "" [ "-" attribute-name ] ) ;
                                                                                                            in
                                                                                                                if builtins.typeOf attribute-value == "lambda" then
                                                                                                                    let
                                                                                                                        x = attribute-value { pkgs = pkgs ; resources = resources ; self = self ; } ;
                                                                                                                        in "${ right-name } ${ builtins.concatStringsSep "" [ "$" "{" left-name "}" ] }/${ x.file }"
                                                                                                                else "${ right-name } ${ builtins.concatStringsSep "" [ "$" "{" left-name "}" ] }" ;
                                                                                                in
                                                                                                    builtins.concatStringsSep "\n" ( builtins.concatLists [ [ "HostName ${ host-name }" ] ( builtins.map ( line : "  ${ line }" ) ( builtins.attrValues ( builtins.mapAttrs mapper value ) ) ) ] ) ;
                                                                            in builtins.mapAttrs mapper configuration ;
                                                                        exports =
                                                                            let
                                                                                mapper =
                                                                                    host-name : value :
                                                                                        let
                                                                                            v =
                                                                                                let
                                                                                                    export = path : value : "export ${ bash-name host-name ( builtins.elemAt path 0 ) }" ;
                                                                                                    in
                                                                                                        visitor
                                                                                                            {
                                                                                                                bool = export ;
                                                                                                                int = export ;
                                                                                                                lambda = export ;
                                                                                                                string = export ;
                                                                                                            }
                                                                                                            value ;
                                                                                            in builtins.concatStringsSep "\n" ( builtins.attrValues v ) ;
                                                                                in builtins.mapAttrs mapper configuration ;
                                                                        roots =
                                                                            let
                                                                                mapper =
                                                                                    host-name : value :
                                                                                        let
                                                                                            v =
                                                                                                visitor
                                                                                                    {
                                                                                                        bool = path : value : [ ] ;
                                                                                                        int = path : value : [ ] ;
                                                                                                        lambda = path : value : [ ( builtins.concatStringsSep " " [ "ln" "--symbolic" ( builtins.concatStringsSep "" [ "\"" "$" "{" ( bash-name host-name ( builtins.elemAt path 0 ) ) "}" "\"" ] ) "/links" ] ) ] ;
                                                                                                        string = path : value : [ ] ;
                                                                                                    }
                                                                                                    value ;
                                                                                            in builtins.concatStringsSep "\n" ( builtins.concatLists ( builtins.attrValues v ) ) ;
                                                                                in builtins.mapAttrs mapper configuration ;
                                                                        in
                                                                            ''
                                                                                ${ builtins.concatStringsSep "\n" ( builtins.attrValues bash ) }
                                                                                ${ builtins.concatStringsSep "\n" ( builtins.attrValues exports ) }
                                                                                ${ builtins.concatStringsSep "\n" ( builtins.attrValues roots ) }
                                                                                envsubst < ${ builtins.toFile "config" ( builtins.concatStringsSep "\n" ( builtins.attrValues dot-ssh ) ) } > /mount/dot-ssh
                                                                                chmod 0400 /mount/dot-ssh
                                                                            '' ;
                                                            } ;
                                                    in "${ application }/bin/init" ;
                                        targets = [ "dot-ssh" ] ;
                                    } ;
                            in
                                {
                                    check =
                                        {
                                            configuration ,
                                            expected ,
                                            failure ,
                                            pkgs ? null ,
                                            resources ? null ,
                                            self ? null
                                        } :
                                            pkgs.stdenv.mkDerivation
                                                {
                                                    installPhase =
                                                        ''
                                                            execute-test "$out"
                                                        '' ;
                                                    name = "check" ;
                                                    nativeBuildInputs =
                                                        [
                                                            (
                                                                pkgs.writeShellApplication
                                                                    {
                                                                        name = "execute-test" ;
                                                                        runtimeInputs = [ pkgs.coreutils failure ] ;
                                                                        text =
                                                                            let
                                                                                init = instance.init { pkgs = pkgs ; resources = resources ; self = self ; } ;
                                                                                instance = implementation configuration ;
                                                                                in
                                                                                    ''
                                                                                        OUT="$1"
                                                                                        touch "$OUT"
                                                                                        ${ if [ "init" "targets" ] != builtins.attrNames instance then ''failure 3186419e "We expected the dot-ssh names to be init targets but we observed ${ builtins.toJSON ( builtins.attrNames instance ) }"'' else "#" }
                                                                                        ${ if expected != init then ''failure 9cc61c07 "We expected the dot-ssh init to be ${ builtins.toString expected } but we observed ${ builtins.toString init }"'' else "#" }
                                                                                        ${ if [ "dot-ssh" ] != implementation.targets then ''failure 09600650 "We expected the dot-ssh targets to be dot-ssh but we observed ${ builtins.toJSON instance.targets }"'' else "#" }
                                                                                    '' ;
                                                                    }
                                                            )
                                                        ] ;
                                                    src = ./. ;
                                                } ;
                                    implementation = implementation ;
                                } ;
            } ;
}