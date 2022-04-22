
echo "Top Jobs :"
grep "DAGScheduler: Job" $1 | grep took | awk '{print $5":"$6" -> "$12" sec"'} | sort -nr -k3 | head
echo "Top Stage :"
grep "DAGScheduler:" $1 | grep "finished in " | awk '{print $5":"$6" -> "$12" secs"'} | sort -nr -k3 | head
echo "Top Tasks :"
grep "TaskSetManager: Finished task" $1 | awk '{print "Task"$7": Stage"$10": => " $14/1000 " seconds"}'| sort -nr -k4 | head
