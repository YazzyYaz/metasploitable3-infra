resource "aws_ec2_client_vpn_endpoint" "main" {
    description = "metasploitable-clientvpn"
    server_certificate_arn = "${aws_acm_certificate.cert.arn}"
    client_cidr_block = "10.0.0.0/16"
    
    authentication_options {
        type = "certificate-authentication"
        root_certificate_chain_arn = "${aws_acm_certificate.root_cert.arn}"
    }

    connection_log_options {
        enabled = true
        cloudwatch_log_group = "${aws_cloudwatch_log_group.lg.name}"
        cloudwatch_log_stream = "${aws_cloudwatch_log_stream.ls.name}"
    }
}

resource "aws_ami" "metasploitable3_ami" {
    name = "metasploitable3"
    virtualization_type = "hvm"
    root_device_name = "/dev/xvda"

    ebs_block_device {
        device_name = "/dev/xvda"
        snapshot_id = "snap-xxxxxx"
        volume_size = 100
    }
}
