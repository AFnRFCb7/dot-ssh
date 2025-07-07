{
	inputs = { } ;
	outputs =
		{ self } :
			{
				lib.implementation =
					{
						config ,
						nixpkgs ,
						system
					} @primary :
						let
										pkgs = builtins.getAttr system nixpkgs.legacyPackages ;
						application =
						pkgs.writeShellApplication
							{
								name = "application" ;
								runtimeInputs = [ pkgs.coreutils ] ;
								text =
									let
										mapper =
											name : value :
												let
													mapper = name : value : "\t${ name }\t\t\t${ value }" ;
													in
														builtins.concatStringsSep
															"\n"
															(
																builtins.concatLists
																	[
																		[ "HOST ${ name }" ]
																		( builtins.attrValues ( builtins.mapAttrs mapper value ) )
																	]
															) ;
										token = "/tmp/resources/${ builtins.hashString "sha512" ( builtins.toJSON primary ) }" ;
										in
											''
												if [ ! -f ${ token } ]
												then
													mkdir --parents /tmp/resources
cat > ${ token } <<EOF
${ builtins.concatStringsSep "\n\n\n" ( builtins.attrValues ( builtins.mapAttrs mapper config ) ) }
EOF
													chmod 0400 ${ token }
												fi
												echo ${ token }
											'' ;
							} ;
					in "${ application }/bin/application" ;
			} ;
}
