#!/bin/bash -x

SED=$(which sed);

#
# config optimizer for neo4j
#

NEO4J_WRAPPER_PROP_FILE="${OPENSHIFT_NEO4J_DIR}/versions/1.9/neo4j-1.9/conf/neo4j-wrapper.conf";

 [ -z "$XMS" ] && { XMS=32; }
 memory_total=`free -m | grep Mem | awk '{print $2}'`;
 [ -z "$XMX" ] && { let XMX=memory_total-35; XMX="${XMX}";  }

$SED -i "s/^#wrapper.java.initmemory/wrapper.java.initmemory/g";
$SED -i "s/^wrapper.java.initmemory=.*/wrapper.java.initmemory=${XMS}/" $NEO4J_WRAPPER_PROP_FILE;

$SED -i "s/^#wrapper.java.maxmemory/wrapper.java.maxmemory/g";
$SED -i "s/^wrapper.java.maxmemory=.*/wrapper.java.maxmemory=${XMX}/" $NEO4J_WRAPPER_PROP_FILE;

