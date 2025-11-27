#
{
    inputs = { } ;
    outputs =
        { self } :
            {
                lib =
                    { failure , visitor } :
                        let
                            implementation =
                                { configuration ? { } , resources ? { } } :
                                    let
                                        implementation-resources = resources ;
                                        in
                                            {
                                                init =
                                                    { mount , pkgs , resources } @primary :
                                                        let
                                                            application =
                                                                pkgs.writeShellApplication
                                                                    {
                                                                        name = "init" ;
                                                                        runtimeInputs = [ pkgs.coreutils pkgs.gettext ] ;
                                                                        text =
                                                                            let
                                                                                alpha =
                                                                                    visitor
                                                                                        {
                                                                                            lambda =
                                                                                                path : value :
                                                                                                    if builtins.length path == 2 then
                                                                                                        let
                                                                                                            resource-name = builtins.concatStringsSep "" [ "A" ( builtins.hashString "sha512" ( builtins.toJSON path ) ) ] ;
                                                                                                            variable-name = builtins.concatStringsSep "" [ "$" resource-name ] ;
                                                                                                            in
                                                                                                                [
                                                                                                                    ''${ resource-name }=${ value primary }''
                                                                                                                    ''root-resource "${ variable-name }"''
                                                                                                                    ''ln --symbolic "${ variable-name }" /mount/stage/${ resource-name }''
                                                                                                                ]
                                                                                                   else builtins.throw "ssh resources is wrongly nested.  values must be two levels deep, but ${ builtins.toJSON path } is ${ builtins.toString ( builtins.length path ) } levels deep." ;
                                                                                            list = concat.list ;
                                                                                            set = concat.set ;
                                                                                        }
                                                                                        implementation-resources ;
                                                                                beta =
                                                                                    let
                                                                                        string =
                                                                                            path : value : check :
                                                                                                if builtins.length path != 2 then builtins.throw "ssh configuration is wrongly nested.  values must be two levels deep, but ${ builtins.toJSON path } is ${ builtins.toString ( builtins.length path ) } levels deep"
                                                                                                else if check then
                                                                                                    let
                                                                                                        attribute = builtins.getAttr attribute-name host ;
                                                                                                        attribute-name = builtins.elemAt path 1 ;
                                                                                                        host = builtins.getAttr host-name implementation-resources ;
                                                                                                        host-name = builtins.elemAt path 0 ;
                                                                                                        value-name = builtins.concatStringsSep "" [ "B" ( builtins.hashString "sha512" ( builtins.toJSON path ) ) ] ;
                                                                                                        in
                                                                                                            if builtins.typeOf implementation-resources != "set" then builtins.throw "ssh configuration is wrongly nested.  resources must be a set"
                                                                                                            else if ! builtins.hasAttr host-name implementation-resources then builtins.throw "ssh configuration is wrongly nested.  resources must have ${ host-name }"
                                                                                                            else if builtins.typeOf host != "set" then builtins.throw "ssh configuration is wrongly nested.  host ${ host-name } must be a set but is a ${ builtins.typeOf host }"
                                                                                                            else if ! builtins.hasAttr attribute-name host then builtins.throw "ssh configuration is wrongly nested.  host ${ host-name } must have ${ attribute-name }"
                                                                                                            else if builtins.typeOf attribute != "lambda" then builtins.throw "ssh configuration is wrongly nested.  attribute ${ attribute-name } of host ${ host-name } must be a lambda"
                                                                                                            else [ ''${ value-name }="${ value }"'' ''export ${ value-name }'' ]
                                                                                                else
                                                                                                    let
                                                                                                        value-name = builtins.concatStringsSep "" [ "B" ( builtins.hashString "sha512" ( builtins.toJSON path ) ) ] ;
                                                                                                        in [ ''${ value-name }=${ value }'' ''export ${ value-name }'' ] ;
                                                                                        in
                                                                                            visitor
                                                                                                {
                                                                                                    bool = path : value : string path ( if value then "Yes" else "No" ) false ;
                                                                                                    float = path : value : string path ( builtins.toString value ) false ;
                                                                                                    int = path : value : string path ( builtins.toString value ) false ;
                                                                                                    lambda =
                                                                                                        path : value :
                                                                                                            let
                                                                                                                resource-name = builtins.concatStringsSep "" [ "A" ( builtins.hashString "sha512" ( builtins.toJSON path ) ) ] ;
                                                                                                                variable-name = builtins.concatStringsSep "" [ "$" "{" resource-name "}" ] ;
                                                                                                                in string path ( builtins.concatStringsSep "/" [ mount "stage" variable-name ( value null ) ] ) true ;
                                                                                                    list = concat.list ;
                                                                                                    null = path : value : builtins.throw "ssh configuration is misconfigured at ${ builtins.toJSON path }  null values are not allowed" ;
                                                                                                    path = path : value : string path ( builtins.toString value ) false ;
                                                                                                    set = concat.set ;
                                                                                                    string = path : value : string path ''"$( cat ${ builtins.toFile "string" value } )" || failure 57b0ea53'' false ;
                                                                                                }
                                                                                                configuration ;
                                                                                concat =
                                                                                    {
                                                                                        list = path : list : if builtins.length path > 2 then builtins.throw "ssh configuration is wrongly nested at ${ builtins.toJSON path }.  paths may be no deeper than 2 but this is ${ builtins.toString ( builtins.length path ) }" else builtins.concatLists list ;
                                                                                        set = path : set : if builtins.length path > 2 then builtins.throw "ssh configuration is wrongly nested at ${ builtins.toJSON path }.  set paths may be no deeper than 2 but this is ${ builtins.toString ( builtins.length path ) }" else builtins.concatLists ( builtins.attrValues set ) ;
                                                                                    } ;
                                                                                gamma =
                                                                                    let
                                                                                        mapper =
                                                                                            host :
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
                                                                                                    host-name ? null ,
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
                                                                                                } @configuration :
                                                                                                    let
                                                                                                        mapper =
                                                                                                            name : value :
                                                                                                                let
                                                                                                                    configuration-name = builtins.replaceStrings [ "-a" "-b" "-c" "-d" "-e" "-f" "-g" "-h" "-i" "-j" "-k" "-l" "-m" "-n" "-o" "-p" "-q" "-r" "-s" "-t" "-u" "-v" "-w" "-x" "-y" "-z" ] [ "A" "" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ] "_${ name }" ;
                                                                                                                    string =
                                                                                                                        ''
                                                                                                                          ${ configuration-name }=${ builtins.concatStringsSep "" [ "$" "{" value "}" ] }
                                                                                                                        '' ;
                                                                                                                    in "  ${ string }" ;
                                                                                                        in builtins.concatStringsSep "\n" ( builtins.concatLists [ [ "Host ${ host }" ] ( builtins.attrValues ( builtins.mapAttrs mapper configuration ) ) ] ) ;
                                                                                        in builtins.mapAttrs mapper configuration ;
                                                                                in
                                                                                    ''
                                                                                        mkdir --parents /mount/stage
                                                                                        if [[ -t 0 ]]
                                                                                        then
                                                                                            # shellcheck disable=SC2034
                                                                                            HAS_STANDARD_INPUT=false
                                                                                            # shellcheck disable=SC2034
                                                                                            STANDARD_INPUT=
                                                                                        else
                                                                                            # shellcheck disable=SC2034
                                                                                            HAS_STANDARD_INPUT=true
                                                                                            # shellcheck disable=SC2034
                                                                                            STANDARD_INPUT="$( cat )" || failure ca6dd82a
                                                                                        fi
                                                                                        ${ builtins.concatStringsSep "\n" alpha }
                                                                                        ${ builtins.concatStringsSep "\n" beta }
                                                                                    '' ;
                                                                    } ;
                                                            init-resources = resources ;
                                                            in "${ application }/bin/init" ;
                                                targets = [ "config" "stage" ] ;
                                            } ;
                            in
                                {
                                    check =
                                        {
                                            configuration ,
                                            expected ,
                                            implementation-resources ,
                                            init-resources ? null ,
                                            mount ? null ,
                                            pkgs ? null
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
                                                                                init = instance.init { mount = mount ; pkgs = pkgs ; resources = init-resources ; } ;
                                                                                instance = implementation { configuration = configuration ; resources = implementation-resources ; } ;
                                                                                in
                                                                                    ''
                                                                                        OUT="$1"
                                                                                        touch "$OUT"
                                                                                        ${ if [ "init" "targets" ] != builtins.attrNames instance then ''failure dot-ssh 3186419e "We expected the dot-ssh names to be init targets but we observed ${ builtins.toJSON ( builtins.attrNames instance ) }"'' else "#" }
                                                                                        ${ if expected != init then ''failure 9cc61c07 dot-ssh "We expected the init to be ${ builtins.toString expected } but we observed ${ builtins.toString init }"'' else "#" }
                                                                                        ${ if [ "config" "stage" ] != instance.targets then ''failure 09600650 dot-ssh "We expected the targets to be dot-ssh but we observed ${ builtins.toJSON instance.targets }"'' else "#" }
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