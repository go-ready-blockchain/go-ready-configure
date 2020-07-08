# Consensus Algorithm & Blockchain 

Design and Implementation of a consensus algorithm to build zero trust model

## Tools 

[GoLang](https://golang.org) - https://golang.org

[Python](https://www.python.org) - https://www.python.org

[AWS DynamoDB](https://aws.amazon.com/dynamodb/) - https://aws.amazon.com/dynamodb/

## GoLang Libraries/Modules

[AWS SDK](https://aws.amazon.com/sdk-for-go/) - https://aws.amazon.com/sdk-for-go/

[Crypto for RSA](https://golang.org/pkg/crypto/) - https://golang.org/pkg/crypto/

[Econding](https://golang.org/pkg/encoding/) - https://golang.org/pkg/encoding/

[SMTP](https://golang.org/pkg/net/smtp/) - https://golang.org/pkg/net/smtp/

[Math](https://golang.org/pkg/math/) - https://golang.org/pkg/math/

[Bytes](https://golang.org/pkg/bytes/) - https://golang.org/pkg/bytes/

[Time](https://golang.org/pkg/time/) - https://golang.org/pkg/time/

## Containerisation 

[Docker](https://www.docker.com) - https://www.docker.com

[Openshift](https://www.openshift.com) - https://www.openshift.com

## Source Code

Located in the **repositories** folder 

1. Blockchain Component - blockchain-go-node
2. Student Component - student-go-node
3. Academic Component - academicdept-go-node
4. Placement Component - placementdept-go-node
5. Company Component - company-go-node

If the repositories folder does not exist 

**Run** 

```sh clone-all.sh```

This will clone all the code into a folder called **repositories**

The system requires AWS DynamoDB to run and AWS credentials

To configure and use AWS 

**Run**

```sh configure.sh```

*In case a message is obtain that says AWS CLI not installed*

*Go to https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html to download the CLI*

**And run**

``` sh configure.sh```

This **script automatically sets up the tables required** for the system to run this **can be verified by going to the AWS Console** and **checking the tables in DynamoDB**
The following tables are created 
1. BLockchain
2. Buffer
3. Encryption
4. Lasthash
5. Publickeys
6. Student

*In case the tables do not get created*

*The python script can be run*

**Install Dependency**

```pip3 install -r requirements.txt```

**Run Python Script**

```python3 setup.py```

## Running the System

*Open each component in a separate terminal(TTY)*

The main file is located in the src folder of the repositories

```cd <dir>/src```

**Run the following command in each termainal**

```go run main.go```

A message will display saying the server is running and listening on localhost

*For Example:*

**Server listening on localhost:8080**

## API Endpoints

1. For all components 

    **Check Usage**

    - Make POST Request to `/usage` endpoint

2. Blockchain Component

    **Print Blockchain**

    - Make POST request to `/print` endpoint 

3. Pipeline 

    1. **Initialise Blockchain**

        - Make POST request to `/createBlockChain`
    
    2. **Add New Student**

        - Make POST request to `/student` with body

            Sample Body

            ```json
            {
              "Usn": "1MS16CS034",
              "Branch": "CSE",
              "Name": "Gaurav",
              "Gender": "Male",
              "Dob": "30-10-1998",
              "Cgpa": "9",
              "Perc10th": "90",
              "Perc12th": "90",
              "Backlog": false,
              "Email": "gauravkarkal@gmail.com",
              "Mobile": "8867454545",
              "Staroffer": true
            }
            ```
    
    3. **Add New Company**

        - Make POST request to `/company` with body

            Sample Body

            ```json
            {
              "company": "GE"
            }
            ```

    4. **Fetch & Notify(Email) Eligible Students**

        - Make POST request to `/send` with body

            Sample Body

            ```json
            {
      	      "company" : "JPMC",
      	      "backlog" : "",
      	      "starOffer" : "",
      	      "branch" : ["CSE","ISE"],
      	      "gender" : "",
      	      "cgpaCond" : "GreaterThan",
      	      "cgpa" : "2",
      	      "perc10thCond" : "GreaterThan",
      	      "perc10th" : "10",
      	      "perc12thCond" : "GreaterThan",
      	      "perc12th" : "10"
            }
            ```

    5. **Student Accepts or Rejects Company** *(Process of notifying the components is automatic but the end points are listed)*

        - Student Recevies Email with two links 
            1. Acceptance Link
            2. Rejection Link
        - Student Clicks link for agreeing or rejecting the company
        - To sit to placment the student clicks the acceptance link in the email or makes GET request to `/handlerequest` by copying the link with the Query Params

        Sample Query Params
        
        ```
        approval: true
        company: JPMC
        name: 1MS16CS034
        ```

        Sample GET Link with Query Params

        ```
        http://localhost:8081?approval=true&company=JPMC&name=1MS16CS034
        ```

        - The student node creates the block
        - Notifies the Academic Department by sending a POST Request to `/verify-AcademicDept` with body
            
            Sample Body
            ```json
            {
              "name":"1MS16CS034",
              "company": "JPMC"
            }
            ```
        - Academic Department notifies Placement Department by sending a POST Request to `/verify-PlacementDept` with body
            
            Sample Body
            ```json
            {
              "name": "1MS16CS034",
              "company": "JPMC"
            }
            ```
        - Placement Department notifies Company they can retrieve the data by sending a POST Request to `/companyRetrieveData` with body

            Sample Body
            ```json
            {
              "name": "1MS16CS034",
              "company": "JPMC" 
            }
            ```
        
        - The transaction is commited and can be verified by printing the blockchain by making POST request to `/print` endpoint to the blockchain component
