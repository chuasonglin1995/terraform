import boto3
import os
import tempfile
import uuid
from PIL import Image

s3_client = boto3.client('s3')
     
def resize_image(image_path, resized_path):
    with Image.open(image_path) as image:
        image.thumbnail((128, 128))
        image.save(resized_path)
     
def lambda_handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key'] 
        filename = os.path.basename(key)
        uuid_dir = '/tmp/{}'.format(uuid.uuid4())
        os.makedirs(uuid_dir, exist_ok=True)
        download_path = '{}/{}'.format(uuid_dir, filename)
        upload_path = '{}/resized-{}'.format(uuid_dir, filename)
        
        new_key = key.replace('images/', 'resized/')
        s3_client.download_file(bucket, key, download_path)
        resize_image(download_path, upload_path)
        s3_client.upload_file(upload_path, bucket, new_key)
