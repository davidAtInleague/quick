component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

	function run() {
		describe( "Global Scopes Spec", function() {
			it( "can add a global scope to an entity", function() {
				var admins = getInstance( "Admin" ).all();
				expect( admins ).toBeArray();
				expect( admins ).toHaveLength( 2 );
				expect( admins[ 1 ].getId() ).toBe( 1 );
				expect( admins[ 2 ].getId() ).toBe( 4 );
			} );

			it( "can run a query without a global scope", function() {
				var admins = getInstance( "Admin" ).withoutGlobalScope( "ofType" ).all();
				expect( admins ).toBeArray();
				expect( admins ).toHaveLength( 5 );
			} );

			it( "does not prevent adding a scope that was prevented from being global", function() {
				var admins = getInstance( "Admin" )
					.withoutGlobalScope( "ofType" )
					.ofType( "admin" )
					.get();
				expect( admins ).toBeArray();
				expect( admins ).toHaveLength( 2 );
				expect( admins[ 1 ].getId() ).toBe( 1 );
				expect( admins[ 2 ].getId() ).toBe( 4 );
			} );

			it( "applies scopes at the beginning so you can execute in qb and it still has been applied", function() {
				var admins = getInstance( "Admin" ).retrieveQuery().get();
				expect( admins ).toBeArray();
				expect( admins ).toHaveLength( 2 );
				expect( admins[ 1 ].id ).toBe( 1 );
				expect( admins[ 2 ].id ).toBe( 4 );
			} );

			it( "applies global scopes when calling fresh", function() {
				var user = getInstance( "UserWithGlobalScope" ).findOrFail( 1 );
				expect( user.getUsername() ).toBe( "elpete" );
				expect( user.getCountryName() ).toBe( "United States" );
				user = user.fresh();
				user = user.fresh();
				expect( user.getUsername() ).toBe( "elpete" );
				expect( user.getCountryName() ).toBe( "United States" );
			} );

			it( "applies global scopes when calling refresh", function() {
				var user = getInstance( "UserWithGlobalScope" ).findOrFail( 1 );
				expect( user.getUsername() ).toBe( "elpete" );
				expect( user.getCountryName() ).toBe( "United States" );
				user.refresh();
				user.refresh();
				expect( user.getUsername() ).toBe( "elpete" );
				expect( user.getCountryName() ).toBe( "United States" );
			} );

			it( "returns global scoped virtual columns with the memento by default", function() {
				var user = getInstance( "UserWithGlobalScope" ).findOrFail( 1 ).getMemento();
				expect( user ).toHaveKey( "countryName" );
				expect( user.countryName ).toBe( "United States" );

				user = getInstance( "UserWithGlobalScope" ).asMemento().findOrFail( 1 );
				expect( user ).toHaveKey( "countryName" );
				expect( user.countryName ).toBe( "United States" );
			} );

            it( "does not apply select bindings from global scopes when doing an aggregate query", function() {
                writeDump( var = 'before' );
                var result = getInstance( "UserWithGlobalScope" ).paginate();
                writeDump( var = 'after' );
                expect( result ).toHaveKey( "pagination" );
                expect( result.pagination ).toHaveKey( "totalRecords" );
                expect( result.pagination.totalRecords ).toBe( 5 );
                expect( result ).toHaveKey( "results" );
                expect( result.results ).toBeArray();
                expect( result.results ).toHaveLength( 5 );
                expect( result.results[ 1 ].getCountryName() ).toBe( "United States" );
            } );
		} );
	}

}
