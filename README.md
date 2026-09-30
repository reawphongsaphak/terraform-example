# terraform

Playing around with AWS networking in Terraform. Runs against real AWS or LocalStack.

## Structure

```
terraform/
├── infrastructure/
│   ├── modules/
│   │   └── vpc/            # reusable VPC: subnets, igw, route tables
│   ├── environment/
│   │   ├── dev/            # dev VPC  (10.1.0.0/16)
│   │   └── sit/            # sit VPC  (10.0.0.0/16)
│   └── global/
│       └── iam/            # account-wide IAM (password policy, admin group)
```

Each folder under `environment/` and `global/` is its own Terraform root with its own state. Run commands inside the one you want:

```bash
cd infrastructure/environment/sit
terraform init
terraform plan
```

## Design

Every environment gets the same VPC from `modules/vpc`, spread over 2 AZs:

```
                 ┌──────────────── VPC (10.0.0.0/16) ────────────────┐
                 │                                                   │
 internet ── igw ┼── public-zone-1  10.0.0.0/24    private-zone-1  10.0.128.0/24
   (0.0.0.0/0)   │── public-zone-2  10.0.1.0/24    private-zone-2  10.0.129.0/24
                 │                                                   │
                 │     all subnets talk to each other via the        │
                 │     VPC router (local 10.0.0.0/16 route)          │
                 └───────────────────────────────────────────────────┘
```

- **Public subnets** (`x.x.0.0/24`, `x.x.1.0/24`): associated with the public route table (`0.0.0.0/0 → igw`), so they can reach the internet. Instances get a public IP on launch.
- **Private subnets** (`x.x.128.0/24`, `x.x.129.0/24`): no association, so they use the VPC main route table, which has only the local route. No internet in or out.
- Public and private can still reach each other through the local route. Security groups decide what's actually allowed.
- dev and sit use different CIDRs so they could be peered later.

Tags: every resource gets `Environment` + `ManagedBy = terraform` from the provider, plus a `Name` like `sit-public-zone-1`.
