Hands-On: Alert on AWS Root Account Login

Mục tiêu
- Enable CloudTrail và gửi logs đến CloudWatch Logs
- Tạo CloudWatch Metric Filter để đếm sự kiện Root login
- Tạo CloudWatch Alarm nếu có Root login trong 5 phút
- Thông báo qua SNS email

File chính
- `terraform/main.tf` - cấu hình CloudTrail, CloudWatch Log Group, Metric Filter, SNS, Alarm
- `terraform/variables.tf` - biến Terraform
- `terraform/outputs.tf` - outputs ARN / alarm name

Chạy thử
1) Cài Terraform và cấu hình AWS credentials.

2) Xem plan:
```bash
cd lab/aMinh/root-login-alert/terraform
terraform init
terraform plan -var="email_address=you@example.com"
```

3) Apply:
```bash
terraform apply -var="email_address=you@example.com" -auto-approve
```

4) Xác nhận subscription: mở email và click link.

5) Chờ CloudTrail ghi log vào CloudWatch Logs: có thể mất vài phút sau khi trail active.

6) Kiểm tra CloudTrail + Alarm:
- AWS Console → CloudTrail → Trails: trail `root-login-trail` phải Active.
- AWS Console → CloudWatch → Logs: log group `/aws/cloudtrail/root-login` phải nhận dữ liệu.
- AWS Console → CloudWatch → Alarms: alarm `root-account-login-alarm`.

6) Test root login cảnh báo
- Dùng Root account login vào AWS Console (hoặc tạo sự kiện root login giả bằng CloudTrail event nếu cần).
- Nếu có event root login, Metric Filter sẽ tạo metric `RootAccountLoginCount` với value 1 và alarm sẽ gửi email.

Dọn dẹp
```bash
terraform destroy -var="email_address=you@example.com" -auto-approve
```

Ghi bằng chứng
- Screenshot CloudTrail trail active.
- Screenshot CloudWatch Logs nhận log.
- Screenshot CloudWatch Alarm `ALARM`.
