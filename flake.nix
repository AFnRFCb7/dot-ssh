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
                                        implementation-resources = builtins.trace "47ccf522af219de07ee3180fed6236b5bc303a233383faac94ae73ab9819cc39a2658a694b5ef9f3dbaecdcee9baf750673784d020b8611633766b06e13447fe" resources ;
                                        in
                                            {
                                                init =
                                                    { mount , pkgs , resources } :
                                                        let
                                                            application =
                                                                pkgs.writeShellApplication
                                                                    {
                                                                        name = "init" ;
                                                                        runtimeInputs = [ pkgs.coreutils pkgs.gettext ] ;
                                                                        text =
                                                                            let
                                                                                mapper =
                                                                                    fun : host :
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
                                                                                        } @value :
                                                                                            fun host value ;
                                                                                alpha =
                                                                                    visitor
                                                                                        {
                                                                                            lambda =
                                                                                                path : value :
                                                                                                    if builtins.length path == 2 then
                                                                                                        let
                                                                                                            resource-name = builtins.concatStringsSep "" [ "A" ( builtins.hashString "sha512" ( builtins.toJSON path ) ) ] ;
                                                                                                            in
                                                                                                                [
                                                                                                                    ''if "$HAS_STANDARD_INPUT" ; then ${ resource-name }=${ value ( setup : ''echo "$STANDARD_INPUT" | ${ setup } "$@"'' ) } ; else ${ resource-name }=${ value ( setup : ''${ setup } "$@"'' ) } ; fi''
                                                                                                                    ''root-resource ${ resource-name }''
                                                                                                                    ''ln --symbolic ${ resource-name } /mount/stage/${ resource-name }''
                                                                                                                ]
                                                                                                    else builtins.throw "ssh resources is wrongly nested.  values must be two levels deep, but ${ builtins.toJSON path } is ${ builtins.toString ( builtins.length path ) } levels deep." ;
                                                                                            list = concat.list ;
                                                                                            set = concat.set ;
                                                                                        }
                                                                                        ( builtins.trace "6227b707c9da7c47bee35d9db6ffe1986c6115a01a86d926605f97180c50caeb139288c7fc13bdc11e3008d37b638fe2db1181805c1f559af426cbdc596dc639" implementation-resources ) ;
                                                                                beta =
                                                                                    let
                                                                                        string =
                                                                                            path : value : check :
                                                                                                if builtins.length path != 2 then builtins.throw "ssh configuration is wrongly nested.  values must be two levels deep, but ${ builtins.toJSON path } is ${ builtins.toString ( builtins.length path ) } levels deep"
                                                                                                else if check then
                                                                                                    let
                                                                                                        host = builtins.getAttr ( builtins.trace "59cc7f2ca0ad92957a6771977de930ddbd10bb75511eb250a2e659642f405c186f47902f2fc2be3d9638c0f4cb7306ad05b3293af36796de8efe25a4e748794f" implementation-resources ) host-name ;
                                                                                                        host-name = builtins.elemAt path 0 ;
                                                                                                        value-name = builtins.concatStringsSep "" [ "B" ( builtins.hashString "sha512" ( builtins.toJSON path ) ) ] ;
                                                                                                        in
                                                                                                            if builtins.typeOf ( builtins.trace "2ed1c0eba04dde99441f3c4670dd3e5fdecae977a2c3182fe4c304dedfdc157bcbb5ba1f5cf1f773982a0961408a2d724f487df2a711d8c0e5ce26016a757c04" implementation-resources ) != "set" then builtins.throw "ssh configuration is wrongly nested.  resources must be a set"
                                                                                                            else if ! builtins.hasAttr host-name ( builtins.trace "642fd3e25d5660d6717c0d06f7b7044b6a553a6c65b0b53c55b22362d34bcd16d0edb2a6425204f042ef14f52fabba9fca65fc6a2acfe4450179c42a77537ab2" implementation-resources ) then builtins.throw "ssh configuration is wrongly nested.  resources must have ${ host-name }"
                                                                                                            else if builtins.typeOf host != "lambda" then builtins.throw "ssh configuration is wrongly nested.  host ${ builtins.toJSON path } must be a lambda"
                                                                                                            else [ ''export ${ value-name }=${ value }'' ]
                                                                                                else
                                                                                                    let
                                                                                                        value-name = builtins.concatStringsSep "" [ "B" ( builtins.hashString "sha512" ( builtins.toJSON path ) ) ] ;
                                                                                                        in [ ''export ${ value-name }=${ value }'' ] ;
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
                                                                                                                in string path ( value ( builtins.concatStringsSep "/" [ mount "stage" variable-name ] ) ) true ;
                                                                                                    list = concat.list ;
                                                                                                    null = path : value : builtins.throw "ssh configuration is misconfigured at ${ builtins.toJSON path }  null values are not allowed" ;
                                                                                                    path = path : value : string path ( builtins.toString value ) false ;
                                                                                                    set = concat.set ;
                                                                                                    string = path : value : string path ''"$( cat ${ builtins.toFile "string" value } )" || failure 57b0ea53'' false ;
                                                                                                }
                                                                                                configuration ;
                                                                                concat =
                                                                                    {
                                                                                        list = path : list : if builtins.length path > 2 then builtins.throw "ssh configuration is wrongly nested at ${ builtins.toJSON path }.  paths may be no deeper than 2 but this is ${ builtins.toString ( builtins.length path ) }" else builtins.concatLists ( builtins.trace "b156aa5602e95829126b4f3b5952ad685d82846c3e537a1a17e851ac639510d1b76feaf42ab851e6ecd966aa733c4f494b27595c4021a11d91594188b811a8e4" list ) ;
                                                                                        set = path : set : if builtins.length path > 2 then builtins.throw "ssh configuration is wrongly nested at ${ builtins.toJSON path }.  set paths may be no deeper than 2 but this is ${ builtins.toString ( builtins.length path ) }" else builtins.concatLists ( builtins.attrValues ( builtins.trace "b11dc30f283842d371b7fe361cda0ea20eb963fcd5a608cda2428d8823264e533e258ceb49da10e7de9adb5e393bc8b418187fcc8748ee0684ae2bd1b85d1834" set ) ) ;
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
                                                                                        ${ builtins.concatStringsSep "\n" ( builtins.attrValues alpha ) }
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
                                                                                instance = implementation { configuration = configuration ; resources = builtins.trace "d95f8e7004bb515389f2ae85601c40b56e866464450c0f236894266f8ac3edfdfc99dc35e73be50aea023966b9f2bbc042d95f314fb701f45a3d4a20ac92b663" implementation-resources ; } ;
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