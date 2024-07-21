import requests
from requests.exceptions import RequestException

def check_application_status(url):
    try:
        response = requests.get(url)
        # Check if the response status code is in the range 200-299
        if 200 <= response.status_code < 300:
            return 'up'
        else:
            return 'down'
    except RequestException as e:
        print(f"An error occurred: {e}")
        return 'down'

if __name__ == "__main__":
    # Replace with the actual URL of the application you want to check
    application_url = "https://github.com/sathishkumar-2001/wisecow_app_on_k8s/blob/main/wisecow-service.yml"
    status = check_application_status(application_url)
    print(f"The application is {status}.")
