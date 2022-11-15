pods_with_limits=""
pods_without_limits=""

for namespace in `kubectl get namespaces | grep -v NAME | cut -d ' ' -f 1` ; do
  for pod in `kubectl get pods -n $namespace | grep -v NAME | cut -d ' ' -f 1` ; do
        limit=`kubectl get pods $pod -n $namespace -o yaml | grep limits`
        if [ ! -z "$limit" ]; then
           pods_with_limits="$pods_with_limits\n$pod,$namespace"
        else
           pods_without_limits="$pods_without_limits\n$pod,$namespace"
        fi
  done
done

echo "Pods With Limits"
echo $pods_with_limits

echo ""
echo ""
echo "========="
echo ""
echo ""

echo "Pods Without Limits"
echo $pods_without_limits