{
    inputs = { } ;
    outputs =
        { self } :
            {
                lib =
                    {
                        coreutils ,
                        visitor ,
                        writeShellApplication
                    } :
                        let
                            implementation =
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
                                    host-name ? null ,
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
                                } @primary :
                                    {
                                        init =
                                            { resources , self } :
                                                let
                                                    application =
                                                        writeShellApplication
                                                            {
                                                                name = "init" ;
                                                                runtimeInputs = [ coreutils ] ;
                                                                text =
                                                                    let
                                                                        bash-name = path : builtins.replacesStrings [ "-" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "u" "v" "w" "x" "y" "z" ] [ "_" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "Y" "Z" ] ( builtins.concatStringsSep "" ( builtins.concatLists [ [ "-" ] path ] ) ) ;
                                                                        configuration =
                                                                            let
                                                                                string = path : value : [ "${ configuration-name path } \$${ bash-name path }" ] ;
                                                                                in
                                                                                    visitor
                                                                                        {
                                                                                            bool = string ;
                                                                                            int = string ;
                                                                                            lambda = string ;
                                                                                            string = string ;
                                                                                        }
                                                                                        primary ;
                                                                        configuration-name = path : builtins.replaceStrings [ "-a" "-b" "-c" "-d" "-e" "-f" "-g" "-h" "-i" "-j" "-k" "-l" "-m" "-n" "-o" "-p" "-q" "-r" "-s" "-t" "-u" "-v" "-w" "-x" "-y" "-z" ] [ "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ] ( builtins.concatStringsSep "" ( builtins.concatLists [ [ "-" ] path ] ) );
                                                                        variables =
                                                                            visitor
                                                                                {
                                                                                    bool = path : value : [ ( builtins.concatStringsSep "" [ ( bash-name path ) "=" ( if value then "Yes" else "No" ) ] ) ] ;
                                                                                    int = path : value : [ ( builtins.concatStringsSep "" [ ( bash-name path ) "=" ( builtins.toString value ) ] ) ] ;
                                                                                    string = path : value : [ ( builtins.concatStringsSep "" [ ( bash-name path ) "=" value ] ) ] ;
                                                                                }
                                                                                primary ;
                                                                        in
                                                                            ''
                                                                                cat ${ builtins.toFile "config" ( builtins.concatStringsSep "" ( builtins.attrValues configuration ) ) } > /mount/dot-ssh
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
                                            mkDerivation ,
                                            resources ? null ,
                                            self ? null
                                        } :
                                            mkDerivation
                                                {
                                                    installPhase =
                                                        ''
                                                            execute-test-attributes "$out"
                                                            execute-test-init "$out"
                                                            execute-test-targets "$out"
                                                        '' ;
                                                    name = "check" ;
                                                    nativeBuildInputs =
                                                        [
                                                            (
                                                                writeShellApplication
                                                                    {
                                                                        name = "execute-test-attributes" ;
                                                                        runtimeInputs = [ coreutils ( failure.implementation "4187683d" ) ] ;
                                                                        text =
                                                                            let
                                                                                observed = builtins.attrNames ( implementation configuration ) ;
                                                                                in
                                                                                    if [ "init" "targets" ] == observed
                                                                                    then
                                                                                        ''
                                                                                            OUT="$1"
                                                                                            touch "$OUT"
                                                                                        ''
                                                                                    else
                                                                                        ''
                                                                                            OUT=$1
                                                                                            touch "$OUT"
                                                                                            failure attributes
                                                                                        '' ;
                                                                    }
                                                            )
                                                            (
                                                                writeShellApplication
                                                                    {
                                                                        name = "execute-test-init" ;
                                                                        runtimeInputs = [ coreutils ( failure.implementation "9507ef9d" ) ] ;
                                                                        text =
                                                                            let
                                                                                x = implementation configuration ;
                                                                                observed = builtins.toString ( x.init { resources = resources ; self = self ; } ) ;
                                                                            in
                                                                                if expected == observed then
                                                                                    ''
                                                                                        OUT="$1"
                                                                                        touch "$OUT"
                                                                                    ''
                                                                                else
                                                                                    ''
                                                                                        OUT="$1"
                                                                                        touch "$OUT"
                                                                                        failure init "We expected ${ expected } but we observed ${ observed }"
                                                                                    '' ;
                                                                    }
                                                            )
                                                            (
                                                                writeShellApplication
                                                                    {
                                                                        name = "execute-test-targets" ;
                                                                        runtimeInputs = [ coreutils ( failure.implementation "8eadd518" ) ] ;
                                                                        text =
                                                                            let
                                                                                x = implementation configuration ;
                                                                                observed = x.targets ;
                                                                                in
                                                                                    if [ "dot-ssh" ] == observed
                                                                                    then
                                                                                        ''
                                                                                            OUT="$1"
                                                                                            touch "$OUT"
                                                                                        ''
                                                                                    else
                                                                                        ''
                                                                                            OUT=$1
                                                                                            touch "$OUT"
                                                                                            failure targets
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