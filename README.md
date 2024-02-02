# RTMP Server CloudFormation Repository

This repository contains a CloudFormation template and resources to quickly deploy an RTMP server on AWS using EC2, Debian, and Nginx.

## Usage

1. Modify parameters as needed.
2. Deploy template using AWS Management Console or AWS CLI.

## Testing

After deployment, you can test the RTMP server using OBS for streaming and VLC for playback.

#### OBS Setup

1. Open OBS and go to "Settings."
2. Under "Stream," select "Custom" for the service.
3. Set the server to your Elastic IP's RTMP URL (e.g., `rtmp://1.2.3.4/live`).
4. Set the stream key to any value (e.g., `myStreamKey`).
5. Click "OK" to save the settings.

#### VLC Playback

1. Open VLC Media Player.
2. Navigate to "Media" -> "Open Network Stream."
3. Enter the RTMP URL of your Elastic IP (e.g., `rtmp://1.2.3.4/live/myStreamKey`).
4. Click "Play" to start playback.

## Repository Structure

### CloudFormation

The `CloudFormation` folder houses an AWS CloudFormation template for setting up and configuring the server.

### Configuration

The `Configuration` folder includes the `nginx.conf` file representing the Nginx server configuration. This is for reference only and does not update the CloudFormation template.

### Scripts

The `Scripts` folder contains the `configure_nginx.sh` script, representing the EC2 instance's startup/user-data script. This is for reference only and does not update the CloudFormation template.

## Acknowledgements

The following resources were referenced in the creation of this project:

* [Setup your own RTMP Server to Receive and Redistribute Live Streaming Video](https://www.youtube.com/watch?v=n-EdUHNK9UIhttps:/) - YouTube video by Doug Johnson Productions
* [How To Set Up a Video Streaming Server using Nginx-RTMP on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-video-streaming-server-using-nginx-rtmp-on-ubuntu-20-04) - Written tutorial provided by Digital Ocean (similar steps for Debian)
