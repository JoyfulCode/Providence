module providence.ddag;

// Interfaces here are for illustrative and conversational purposes
// Data structures are intended to show relationships and do not necessarily imply an 
// implementation would use a particular structural representation

struct ActionDefintion
{
    DataDefinition[] declaredInputs;
    DataDefinition[] declaredOutputs; 
    Action action;
}

struct DataDefinition
{
    DataSource source;
}

struct Node
{
    NodeId id;
}

struct DataNode : Node
{
    DataDefinition data;
    ActionNode[] consumingActions;
}

struct ActionNode : Node
{
    DataNode[] inputs;
    DataNode[] outputs;
    ActionDefinition action;
}

/** Used to alter the graph at design time */
interface DesignTimeDependencyGraph
{
    ActionNode AddAction(ActionDefinition ad);
    DataNode AddData(DataDefinition dd);
    void RemoveNode(NodeId id);
    void GetNode(NodeId id);
    ActionNode[] GetActionNodes();
    DataNode[] GetDataNodes();
    ActionNode[] GetActionsConsumingData(DataDefinition data);
}

/** Used to query and update the graph at runtime */
interface RuntimeDependencyGraph
{
    /** Given a set of data, return the set of actions
     *  whose outputs may now be out-of-date.
     */
    ActionNode[] NotifyDataChanged(DataDefinition[] changedData);

    /** Given an ActionNode and result data, update the graph to add/remove data
     *  nodes and report which ActionNodes' inputs are affected.
     */
    ActionNode[] ReportActionResult(ActionNode action, DataDefinition[] data);
}

