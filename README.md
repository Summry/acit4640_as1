# ACIT 4640 - Assignment 1 Terraform and AWS

Provision aws infrastructure using terraform. Describe your active infrastructure using AWS CLI and plop the results here.

## Team Members

- Nazira Fakhrurradi

## Assignment Video

- [Placeholder](https://www.youtube.com/watch?v=oh0RQ_TgDnQ)

## AWS CLI Describe Commands

### Describe VPCs

```
aws ec2 describe-vpcs
```

My results:

```yaml
Vpcs:
  - CidrBlock: 10.0.0.0/16
    CidrBlockAssociationSet:
      - AssociationId: vpc-cidr-assoc-076c682bbcb22b655
        CidrBlock: 10.0.0.0/16
        CidrBlockState:
          State: associated
    DhcpOptionsId: dopt-09cdd3c310ce4d412
    InstanceTenancy: default
    IsDefault: false
    OwnerId: "514906446556"
    State: available
    VpcId: vpc-03d2e67877fc392a7
```

### Describe Route Tables

```
aws ec2 describe-route-tables
```

My results:

```yaml
RouteTables:
  - Associations:
      - AssociationState:
          State: associated
        Main: false
        RouteTableAssociationId: rtbassoc-0283c6046d97eff7e
        RouteTableId: rtb-066cd250d4119ae2d
        SubnetId: subnet-001d2964ba7322888
    OwnerId: "514906446556"
    PropagatingVgws: []
    RouteTableId: rtb-066cd250d4119ae2d
    Routes:
      - DestinationCidrBlock: 10.0.0.0/16
        GatewayId: local
        Origin: CreateRouteTable
        State: active
      - DestinationCidrBlock: 0.0.0.0/0
        GatewayId: igw-081a0ac96dcdc6fc3
        Origin: CreateRoute
        State: active
    Tags: []
    VpcId: vpc-03d2e67877fc392a7
  - Associations:
      - AssociationState:
          State: associated
        Main: true
        RouteTableAssociationId: rtbassoc-06c81e360e2f03631
        RouteTableId: rtb-0f2ac8802bdba9eab
    OwnerId: "514906446556"
    PropagatingVgws: []
    RouteTableId: rtb-0f2ac8802bdba9eab
    Routes:
      - DestinationCidrBlock: 10.0.0.0/16
        GatewayId: local
        Origin: CreateRouteTable
        State: active
    Tags: []
    VpcId: vpc-03d2e67877fc392a7
```

### Describe Internet Gateways

```
aws ec2 describe-internet-gateways
```

My results:

```yaml
InternetGateways:
  - Attachments:
      - State: available
        VpcId: vpc-03d2e67877fc392a7
    InternetGatewayId: igw-081a0ac96dcdc6fc3
    OwnerId: "514906446556"
    Tags: []
```

### Describe Security Groups

```
aws ec2 describe-security-groups
```

My results:

```yaml
SecurityGroups:
  - Description: security group for private subnet
    GroupId: sg-0c6ac21487bb28f4d
    GroupName: privatesg
    IpPermissions:
      - FromPort: 80
        IpProtocol: tcp
        IpRanges:
          - CidrIp: 10.0.0.0/16
        Ipv6Ranges: []
        PrefixListIds: []
        ToPort: 80
        UserIdGroupPairs: []
      - FromPort: 22
        IpProtocol: tcp
        IpRanges:
          - CidrIp: 10.0.0.0/16
        Ipv6Ranges: []
        PrefixListIds: []
        ToPort: 22
        UserIdGroupPairs: []
    IpPermissionsEgress: []
    OwnerId: "514906446556"
    VpcId: vpc-03d2e67877fc392a7
  - Description: default VPC security group
    GroupId: sg-093d3f88101b269af
    GroupName: default
    IpPermissions:
      - IpProtocol: "-1"
        IpRanges: []
        Ipv6Ranges: []
        PrefixListIds: []
        UserIdGroupPairs:
          - GroupId: sg-093d3f88101b269af
            UserId: "514906446556"
    IpPermissionsEgress:
      - IpProtocol: "-1"
        IpRanges:
          - CidrIp: 0.0.0.0/0
        Ipv6Ranges: []
        PrefixListIds: []
        UserIdGroupPairs: []
    OwnerId: "514906446556"
    VpcId: vpc-03d2e67877fc392a7
  - Description: security group for public subnet
    GroupId: sg-0f4b42bc3abe7159e
    GroupName: publicsg
    IpPermissions:
      - FromPort: 80
        IpProtocol: tcp
        IpRanges:
          - CidrIp: 0.0.0.0/0
        Ipv6Ranges: []
        PrefixListIds: []
        ToPort: 80
        UserIdGroupPairs: []
      - FromPort: 22
        IpProtocol: tcp
        IpRanges:
          - CidrIp: 0.0.0.0/0
        Ipv6Ranges: []
        PrefixListIds: []
        ToPort: 22
        UserIdGroupPairs: []
    IpPermissionsEgress:
      - IpProtocol: "-1"
        IpRanges:
          - CidrIp: 0.0.0.0/0
        Ipv6Ranges: []
        PrefixListIds: []
        UserIdGroupPairs: []
    OwnerId: "514906446556"
    VpcId: vpc-03d2e67877fc392a7
```

### Describe EC2 Instances

```
aws ec2 describe-instances
```

My results:

```yaml
Reservations:
  - Groups: []
    Instances:
      - AmiLaunchIndex: 0
        Architecture: x86_64
        BlockDeviceMappings: []
        BootMode: uefi-preferred
        CapacityReservationSpecification:
          CapacityReservationPreference: open
        ClientToken: terraform-20240215031849868800000003
        CpuOptions:
          CoreCount: 1
          ThreadsPerCore: 1
        CurrentInstanceBootMode: legacy-bios
        EbsOptimized: false
        EnaSupport: true
        EnclaveOptions:
          Enabled: false
        HibernationOptions:
          Configured: false
        Hypervisor: xen
        ImageId: ami-04eed88b1a6b28477
        InstanceId: i-0c3e6cde8fc214bfd
        InstanceType: t2.micro
        KeyName: 4640_key
        LaunchTime: "2024-02-15T03:18:50+00:00"
        MaintenanceOptions:
          AutoRecovery: default
        MetadataOptions:
          HttpEndpoint: enabled
          HttpProtocolIpv6: disabled
          HttpPutResponseHopLimit: 1
          HttpTokens: optional
          InstanceMetadataTags: disabled
          State: pending
        Monitoring:
          State: disabled
        NetworkInterfaces: []
        Placement:
          AvailabilityZone: us-west-2a
          GroupName: ""
          Tenancy: default
        PlatformDetails: Linux/UNIX
        PrivateDnsName: ""
        ProductCodes: []
        PublicDnsName: ""
        RootDeviceName: /dev/sda1
        RootDeviceType: ebs
        SecurityGroups: []
        State:
          Code: 48
          Name: terminated
        StateReason:
          Code: Client.UserInitiatedShutdown
          Message: "Client.UserInitiatedShutdown: User initiated shutdown"
        StateTransitionReason: User initiated (2024-02-15 03:35:46 GMT)
        Tags:
          - Key: Name
            Value: assignment1-public-ubuntu
        UsageOperation: RunInstances
        UsageOperationUpdateTime: "2024-02-15T03:18:50+00:00"
        VirtualizationType: hvm
    OwnerId: "514906446556"
    ReservationId: r-00bd1e49d4ebebe88
  - Groups: []
    Instances:
      - AmiLaunchIndex: 0
        Architecture: x86_64
        BlockDeviceMappings: []
        BootMode: uefi-preferred
        CapacityReservationSpecification:
          CapacityReservationPreference: open
        ClientToken: terraform-20240215034446423600000003
        CpuOptions:
          CoreCount: 1
          ThreadsPerCore: 1
        CurrentInstanceBootMode: legacy-bios
        EbsOptimized: false
        EnaSupport: true
        EnclaveOptions:
          Enabled: false
        HibernationOptions:
          Configured: false
        Hypervisor: xen
        ImageId: ami-04eed88b1a6b28477
        InstanceId: i-030ea4185c19d9146
        InstanceType: t2.micro
        KeyName: 4640_key
        LaunchTime: "2024-02-15T03:44:47+00:00"
        MaintenanceOptions:
          AutoRecovery: default
        MetadataOptions:
          HttpEndpoint: enabled
          HttpProtocolIpv6: disabled
          HttpPutResponseHopLimit: 1
          HttpTokens: optional
          InstanceMetadataTags: disabled
          State: pending
        Monitoring:
          State: disabled
        NetworkInterfaces: []
        Placement:
          AvailabilityZone: us-west-2a
          GroupName: ""
          Tenancy: default
        PlatformDetails: Linux/UNIX
        PrivateDnsName: ""
        ProductCodes: []
        PublicDnsName: ""
        RootDeviceName: /dev/sda1
        RootDeviceType: ebs
        SecurityGroups: []
        State:
          Code: 48
          Name: terminated
        StateReason:
          Code: Client.UserInitiatedShutdown
          Message: "Client.UserInitiatedShutdown: User initiated shutdown"
        StateTransitionReason: User initiated (2024-02-15 04:01:19 GMT)
        Tags:
          - Key: Name
            Value: assignment1-public-ubuntu
        UsageOperation: RunInstances
        UsageOperationUpdateTime: "2024-02-15T03:44:47+00:00"
        VirtualizationType: hvm
    OwnerId: "514906446556"
    ReservationId: r-07150f886024a3466
  - Groups: []
    Instances:
      - AmiLaunchIndex: 0
        Architecture: x86_64
        BlockDeviceMappings: []
        BootMode: uefi-preferred
        CapacityReservationSpecification:
          CapacityReservationPreference: open
        ClientToken: terraform-20240215031840335800000002
        CpuOptions:
          CoreCount: 1
          ThreadsPerCore: 1
        CurrentInstanceBootMode: legacy-bios
        EbsOptimized: false
        EnaSupport: true
        EnclaveOptions:
          Enabled: false
        HibernationOptions:
          Configured: false
        Hypervisor: xen
        ImageId: ami-04eed88b1a6b28477
        InstanceId: i-09e82e1dfab692f03
        InstanceType: t2.micro
        KeyName: 4640_key
        LaunchTime: "2024-02-15T03:18:41+00:00"
        MaintenanceOptions:
          AutoRecovery: default
        MetadataOptions:
          HttpEndpoint: enabled
          HttpProtocolIpv6: disabled
          HttpPutResponseHopLimit: 1
          HttpTokens: optional
          InstanceMetadataTags: disabled
          State: pending
        Monitoring:
          State: disabled
        NetworkInterfaces: []
        Placement:
          AvailabilityZone: us-west-2a
          GroupName: ""
          Tenancy: default
        PlatformDetails: Linux/UNIX
        PrivateDnsName: ""
        ProductCodes: []
        PublicDnsName: ""
        RootDeviceName: /dev/sda1
        RootDeviceType: ebs
        SecurityGroups: []
        State:
          Code: 48
          Name: terminated
        StateReason:
          Code: Client.UserInitiatedShutdown
          Message: "Client.UserInitiatedShutdown: User initiated shutdown"
        StateTransitionReason: User initiated (2024-02-15 03:35:46 GMT)
        Tags:
          - Key: Name
            Value: assignment1-private-ubuntu
        UsageOperation: RunInstances
        UsageOperationUpdateTime: "2024-02-15T03:18:41+00:00"
        VirtualizationType: hvm
    OwnerId: "514906446556"
    ReservationId: r-06bb62d57c87aa699
  - Groups: []
    Instances:
      - AmiLaunchIndex: 0
        Architecture: x86_64
        BlockDeviceMappings:
          - DeviceName: /dev/sda1
            Ebs:
              AttachTime: "2024-02-15T04:07:53+00:00"
              DeleteOnTermination: true
              Status: attached
              VolumeId: vol-0937cd9e362187080
        BootMode: uefi-preferred
        CapacityReservationSpecification:
          CapacityReservationPreference: open
        ClientToken: terraform-20240215040752493700000002
        CpuOptions:
          CoreCount: 1
          ThreadsPerCore: 1
        CurrentInstanceBootMode: legacy-bios
        EbsOptimized: false
        EnaSupport: true
        EnclaveOptions:
          Enabled: false
        HibernationOptions:
          Configured: false
        Hypervisor: xen
        ImageId: ami-04eed88b1a6b28477
        InstanceId: i-0344f8ef7444a406b
        InstanceType: t2.micro
        KeyName: 4640_key
        LaunchTime: "2024-02-15T04:07:53+00:00"
        MaintenanceOptions:
          AutoRecovery: default
        MetadataOptions:
          HttpEndpoint: enabled
          HttpProtocolIpv6: disabled
          HttpPutResponseHopLimit: 1
          HttpTokens: optional
          InstanceMetadataTags: disabled
          State: applied
        Monitoring:
          State: disabled
        NetworkInterfaces:
          - Attachment:
              AttachTime: "2024-02-15T04:07:53+00:00"
              AttachmentId: eni-attach-0c373043bcb07858f
              DeleteOnTermination: true
              DeviceIndex: 0
              NetworkCardIndex: 0
              Status: attached
            Description: ""
            Groups:
              - GroupId: sg-0c6ac21487bb28f4d
                GroupName: privatesg
            InterfaceType: interface
            Ipv6Addresses: []
            MacAddress: 02:78:56:7b:68:5b
            NetworkInterfaceId: eni-0b322f66870cf42b4
            OwnerId: "514906446556"
            PrivateIpAddress: 10.0.2.232
            PrivateIpAddresses:
              - Primary: true
                PrivateIpAddress: 10.0.2.232
            SourceDestCheck: true
            Status: in-use
            SubnetId: subnet-0d4f6fd5e6da24543
            VpcId: vpc-03d2e67877fc392a7
        Placement:
          AvailabilityZone: us-west-2a
          GroupName: ""
          Tenancy: default
        PlatformDetails: Linux/UNIX
        PrivateDnsName: ip-10-0-2-232.us-west-2.compute.internal
        PrivateDnsNameOptions:
          EnableResourceNameDnsAAAARecord: false
          EnableResourceNameDnsARecord: false
          HostnameType: ip-name
        PrivateIpAddress: 10.0.2.232
        ProductCodes: []
        PublicDnsName: ""
        RootDeviceName: /dev/sda1
        RootDeviceType: ebs
        SecurityGroups:
          - GroupId: sg-0c6ac21487bb28f4d
            GroupName: privatesg
        SourceDestCheck: true
        State:
          Code: 16
          Name: running
        StateTransitionReason: ""
        SubnetId: subnet-0d4f6fd5e6da24543
        Tags:
          - Key: Name
            Value: assignment1-private-ubuntu
        UsageOperation: RunInstances
        UsageOperationUpdateTime: "2024-02-15T04:07:53+00:00"
        VirtualizationType: hvm
        VpcId: vpc-03d2e67877fc392a7
    OwnerId: "514906446556"
    ReservationId: r-03ef0f7fc467285a1
  - Groups: []
    Instances:
      - AmiLaunchIndex: 0
        Architecture: x86_64
        BlockDeviceMappings:
          - DeviceName: /dev/sda1
            Ebs:
              AttachTime: "2024-02-15T04:08:04+00:00"
              DeleteOnTermination: true
              Status: attached
              VolumeId: vol-0ad17abb592a4b75f
        BootMode: uefi-preferred
        CapacityReservationSpecification:
          CapacityReservationPreference: open
        ClientToken: terraform-20240215040802038600000003
        CpuOptions:
          CoreCount: 1
          ThreadsPerCore: 1
        CurrentInstanceBootMode: legacy-bios
        EbsOptimized: false
        EnaSupport: true
        EnclaveOptions:
          Enabled: false
        HibernationOptions:
          Configured: false
        Hypervisor: xen
        ImageId: ami-04eed88b1a6b28477
        InstanceId: i-0ce0804a4968add88
        InstanceType: t2.micro
        KeyName: 4640_key
        LaunchTime: "2024-02-15T04:08:03+00:00"
        MaintenanceOptions:
          AutoRecovery: default
        MetadataOptions:
          HttpEndpoint: enabled
          HttpProtocolIpv6: disabled
          HttpPutResponseHopLimit: 1
          HttpTokens: optional
          InstanceMetadataTags: disabled
          State: applied
        Monitoring:
          State: disabled
        NetworkInterfaces:
          - Association:
              IpOwnerId: amazon
              PublicDnsName: ""
              PublicIp: 54.149.157.133
            Attachment:
              AttachTime: "2024-02-15T04:08:03+00:00"
              AttachmentId: eni-attach-01181ac6e0fe38941
              DeleteOnTermination: true
              DeviceIndex: 0
              NetworkCardIndex: 0
              Status: attached
            Description: ""
            Groups:
              - GroupId: sg-0f4b42bc3abe7159e
                GroupName: publicsg
            InterfaceType: interface
            Ipv6Addresses: []
            MacAddress: 02:a3:25:e8:81:29
            NetworkInterfaceId: eni-0fe05dc9a424afa24
            OwnerId: "514906446556"
            PrivateIpAddress: 10.0.1.104
            PrivateIpAddresses:
              - Association:
                  IpOwnerId: amazon
                  PublicDnsName: ""
                  PublicIp: 54.149.157.133
                Primary: true
                PrivateIpAddress: 10.0.1.104
            SourceDestCheck: true
            Status: in-use
            SubnetId: subnet-001d2964ba7322888
            VpcId: vpc-03d2e67877fc392a7
        Placement:
          AvailabilityZone: us-west-2a
          GroupName: ""
          Tenancy: default
        PlatformDetails: Linux/UNIX
        PrivateDnsName: ip-10-0-1-104.us-west-2.compute.internal
        PrivateDnsNameOptions:
          EnableResourceNameDnsAAAARecord: false
          EnableResourceNameDnsARecord: false
          HostnameType: ip-name
        PrivateIpAddress: 10.0.1.104
        ProductCodes: []
        PublicDnsName: ""
        PublicIpAddress: 54.149.157.133
        RootDeviceName: /dev/sda1
        RootDeviceType: ebs
        SecurityGroups:
          - GroupId: sg-0f4b42bc3abe7159e
            GroupName: publicsg
        SourceDestCheck: true
        State:
          Code: 16
          Name: running
        StateTransitionReason: ""
        SubnetId: subnet-001d2964ba7322888
        Tags:
          - Key: Name
            Value: assignment1-public-ubuntu
        UsageOperation: RunInstances
        UsageOperationUpdateTime: "2024-02-15T04:08:03+00:00"
        VirtualizationType: hvm
        VpcId: vpc-03d2e67877fc392a7
    OwnerId: "514906446556"
    ReservationId: r-0a39995c027366f6e
  - Groups: []
    Instances:
      - AmiLaunchIndex: 0
        Architecture: x86_64
        BlockDeviceMappings: []
        BootMode: uefi-preferred
        CapacityReservationSpecification:
          CapacityReservationPreference: open
        ClientToken: terraform-20240215034436943900000002
        CpuOptions:
          CoreCount: 1
          ThreadsPerCore: 1
        CurrentInstanceBootMode: legacy-bios
        EbsOptimized: false
        EnaSupport: true
        EnclaveOptions:
          Enabled: false
        HibernationOptions:
          Configured: false
        Hypervisor: xen
        ImageId: ami-04eed88b1a6b28477
        InstanceId: i-00592d4759a5e5a4b
        InstanceType: t2.micro
        KeyName: 4640_key
        LaunchTime: "2024-02-15T03:44:37+00:00"
        MaintenanceOptions:
          AutoRecovery: default
        MetadataOptions:
          HttpEndpoint: enabled
          HttpProtocolIpv6: disabled
          HttpPutResponseHopLimit: 1
          HttpTokens: optional
          InstanceMetadataTags: disabled
          State: pending
        Monitoring:
          State: disabled
        NetworkInterfaces: []
        Placement:
          AvailabilityZone: us-west-2a
          GroupName: ""
          Tenancy: default
        PlatformDetails: Linux/UNIX
        PrivateDnsName: ""
        ProductCodes: []
        PublicDnsName: ""
        RootDeviceName: /dev/sda1
        RootDeviceType: ebs
        SecurityGroups: []
        State:
          Code: 48
          Name: terminated
        StateReason:
          Code: Client.UserInitiatedShutdown
          Message: "Client.UserInitiatedShutdown: User initiated shutdown"
        StateTransitionReason: User initiated (2024-02-15 04:01:19 GMT)
        Tags:
          - Key: Name
            Value: assignment1-private-ubuntu
        UsageOperation: RunInstances
        UsageOperationUpdateTime: "2024-02-15T03:44:37+00:00"
        VirtualizationType: hvm
    OwnerId: "514906446556"
    ReservationId: r-0641da1003a5c6293
```

# [Go to top](#acit-4640---assignment-1-terraform-and-aws)
