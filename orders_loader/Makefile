tf-apply:
	terraform -chdir=infra init
	terraform -chdir=infra plan
	terraform -chdir=infra apply

lmd-logs:
	aws logs tail /aws/lambda/orders-loader-lambda --follow

lmd-invoke:
	aws lambda invoke --function-name orders-loader-lambda out.log

lmd-build:
	sh build-lambda.sh
