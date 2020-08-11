interface displayname="IRelationship" {

	/**
	 * Sets the relation method name for this relationship.
	 *
	 * @name     The relation method name for this relationship.
	 *
	 * @return   IRelationship
	 */
	public IRelationship function setRelationMethodName( required string name );

	/**
	 * Retrieves the entities for eager loading.
	 *
	 * @doc_generic  quick.models.BaseEntity
	 * @return       [quick.models.BaseEntity]
	 */
	public array function getEager();

	/**
	 * Gets the first matching record for the relationship.
	 * Returns null if no record is found.
	 *
	 * @return   quick.models.BaseEntity
	 */
	public any function first();

	/**
	 * Gets the first matching record for the relationship.
	 * Throws an exception if no record is found.
	 *
	 * @throws   EntityNotFound
	 *
	 * @return   quick.models.BaseEntity
	 */
	public any function firstOrFail();

	/**
	 * Finds the first matching record with a given id for the relationship.
	 * Returns null if no record is found.
	 *
	 * @id       The id of the entity to find.
	 *
	 * @return   quick.models.BaseEntity
	 */
	public any function find( required any id );

	/**
	 * Finds the first matching record with a given id for the relationship.
	 * Throws an exception if no record is found.
	 *
	 * @id       The id of the entity to find.
	 *
	 * @throws   EntityNotFound
	 *
	 * @return   quick.models.BaseEntity
	 */
	public any function findOrFail( required any id );

	/**
	 * Returns all results for the related entity.
	 * Note: `all` resets any query restrictions, including relationship restrictions.
	 *
	 * @doc_generic  quick.models.BaseEntity
	 * @return       [quick.models.BaseEntity]
	 */
	public array function all();

	/**
	 * Wrapper for `getResults()` on relationship types that have them.
	 * `get()` implemented for consistency with qb and Quick.
	 *
	 * @return   quick.models.BaseEntity or [quick.models.BaseEntity]
	 */
	public any function get();

	/**
	 * Returns the result of the relationship.
	 * If a null is returned, an optional default model can be returned.
	 * The default model can be configured using a `withDefault` method.
	 *
	 * @return  quick.models.BaseEntity | null
	 */
	public any function getResults();

	/**
	 * Retrieves the values of the key from each entity passed.
	 *
	 * @entities  An array of entities to retrieve keys.
	 * @key       The key to retrieve from each entity.
	 *
	 * @doc_generic  any
	 * @return   [any]
	 */
	public array function getKeys( required array entities, required array keys );

	/**
	 * Initializes the relation to the null value for each entity in an array.
	 *
	 * @entities     The entities to initialize the relation.
	 * @relation     The name of the relation to initialize.
	 *
	 * @doc_generic  quick.models.BaseEntity
	 * @return       [quick.models.BaseEntity]
	 */
	public array function initRelation( required array entities, required string relation );

	/**
	 * Matches the array of entity results to an array of entities for a relation.
	 * Any matched records are populated into the matched entity's relation.
	 *
	 * @entities     The entities being eager loaded.
	 * @results      The relationship results.
	 * @relation     The relation name being loaded.
	 *
	 * @doc_generic  quick.models.BaseEntity
	 * @return       [quick.models.BaseEntity]
	 */
	public array function match(
		required array entities,
		required array results,
		required string relation
	);

	/**
	 * Returns the fully-qualified local key.
	 *
	 * @doc_generic  String
	 * @return       [String]
	 */
	public array function getExistanceLocalKeys();

	/**
	 * Associates the given entity when the relationship is used as a setter.
	 *
	 * Relationships on entities can be called with `set` in front of it.
	 * If it is, a `BelongsTo` relationship forwards the call to `associate`.
	 *
	 * @entity  The entity or entity id to associate as the new owner.
	 *          If an entity is passed, it is also cached in the child entity
	 *          as the value for the relationship.
	 *
	 * @return  quick.models.BaseEntity
	 */
	public any function applySetter();

	/**
	 * Checks if all of the keys (usually foreign keys) on the specified entity are null. Used to determine whether we should even run a relationship query or just return null.
	 *
	 * @fields An array of field names to check on the parent entity
	 *
	 * @return true if all keys are null; false if any foreign keys have a value
	 */
	public boolean function fieldsAreNull( required any entity, required array fields );

	/**
	 * Adds the constraints to the related entity.
	 *
	 * @return  void
	 */
	public void function addConstraints();

	/**
	 * Adds the constraints for eager loading.
	 *
	 * @entities  The entities being eager loaded.
	 *
	 * @return    quick.models.Relationships.BelongsTo
	 */
	public BelongsTo function addEagerConstraints( required array entities );

	/**
	 * Gets the query used to check for relation existance.
	 *
	 * @base    The base entity for the query.
	 *
	 * @return  quick.models.BaseEntity | qb.models.Query.QueryBuilder
	 */
	public any function addCompareConstraints( any base );

	public any function nestCompareConstraints( required any base, required any nested );

	/**
	 * Returns the fully-qualified local key.
	 *
	 * @doc_generic  String
	 * @return       [String]
	 */
	public array function getQualifiedLocalKeys();

	/**
	 * Returns the fully-qualified column name of foreign key.
	 *
	 * @doc_generic  String
	 * @return       [String]
	 */
	public array function getQualifiedForeignKeyNames();

	/**
	 * Returns the fully-qualified local key.
	 *
	 * @doc_generic  String
	 * @return       [String]
	 */
	public array function getExistanceLocalKeys();

	/**
	 * Get the key to compare in the existence query.
	 *
	 * @doc_generic  String
	 * @return       [String]
	 */
	public array function getExistenceCompareKeys();

	/**
	 * Returns the related entity for the relationship.
	 */
	public any function getRelated();

	/**
	 * Applies the join for relationship in a `hasManyThrough` chain.
	 *
	 * @base    The query to apply the join to.
	 *
	 * @return  void
	 */
	public QuickBuilder function applyThroughExists( required QuickBuilder base );

	public QuickBuilder function initialThroughConstraints();

	/**
	 * Applies the constraints for the final relationship in a `hasManyThrough` chain.
	 *
	 * @base    The query to apply the constraints to.
	 *
	 * @return  void
	 */
	public void function applyThroughConstraints( required any base );

	/**
	 * Applies the join for relationship in a `hasManyThrough` chain.
	 *
	 * @base    The query to apply the join to.
	 *
	 * @return  void
	 */
	public void function applyThroughJoin( required any base );

	/**
	 * Flags the entity to return a default entity if the relation returns null.
	 *
	 * @return  quick.models.Relationships.IRelationship
	 */
	public IRelationship function withDefault( any attributes );

	/**
	 * Applies a suffix to an alias for the relationship.
	 *
	 * @suffix   The suffix to append.
	 *
	 * @return  quick.models.Relationships.IRelationship
	 */
	public IRelationship function applyAliasSuffix( required string suffix );

	/**
	 * Retrieves the current query builder instance.
	 *
	 * @return  quick.models.QuickBuilder
	 */
	public QuickBuilder function retrieveQuery();

	public array function getForeignKeys();

	public array function getLocalKeys();

}
