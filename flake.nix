{
	inputs = { } ;
	outputs =
		{ self } :
			{
				lib.implementation =
					{
						config ,
						nixpgs ,
						system
					} @primary :
						pkgs.writeShellApplication
							{
								name = "application" ;
								runtimeInputs = [ pkgs.coreutils ] ;
								text =
									let
										mapper =
											name : value :
												let
													mapper = "\t${ name }\t${ value }" ;
													in builtins.concatStringsSep "\n" ( builtins.attrValues ( builtins.mapAttrs mapper value ) ) ;
										pkgs = builtins.getAttr system nixpkgs.legacyPackages ;
										token = "/tmp/resources/${ builtins.hashString "sha512" primary }" ;
										in
											''
												if [ ! -f ${ token } ]
												then
													mkdir --parents /tmp/resources
													cat > ${ token } <<EOF
												${ builtins.conctStringsSep "\n\n\n" ( builtins.attrValues ( builtins.mapAttrs mapper config ) ) }
												EOF
													chmod 0400 ${ token }
												fi
												echo ${ token }
											'' ;
							} ;
			} ;
}
