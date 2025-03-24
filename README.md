# CIS Compliance Checker for Windows 11 Enterprise

This project is a PowerShell-based tool designed to automate the process of checking Windows 11 Enterprise systems for compliance with the **CIS (Center for Internet Security) Benchmark**. The tool generates detailed reports in CSV format, categorizing checks into different sections and providing recommendations for non-compliant configurations.

---

## **Features**

- **Automated Compliance Checks**: Performs checks for various CIS Benchmark categories, including:
  - Password Policies
  - Account Lockout Policies
  - User Rights Assignment
  - Security Options
  - Windows Defender Firewall
  - Windows Update Settings
  - And more!
- **CSV Reports**: Generates professional and organized CSV reports for each category of checks.
- **Customizable**: Easily extendable to include additional checks or modify existing ones.
- **PowerShell-Based**: Built using PowerShell for compatibility with Windows systems.

---

## **Getting Started**

### **Prerequisites**

- **PowerShell**: Ensure PowerShell is installed on your system.
- **ImportExcel Module**: Install the `ImportExcel` module for CSV export functionality. Run the following command in PowerShell:
  ```powershell
  Install-Module -Name ImportExcel -Force -Scope CurrentUser
  ```

### **Installation**

Clone this repository to your local machine:

```bash
git clone https://github.com/ethic-bakeery/Windows11-CIS-Audit-Benchmark-.git
```

Navigate to the project directory:

```bash
cd Windows11-CIS-Audit-Benchmark
```

### **Usage**

1. Open PowerShell with administrative privileges.
2. Run the script:

   ```powershell
   .\Run-Audit.ps1
   ```

3. The script will generate CSV reports in the `CIS_Compliance_Report` folder on your desktop.

---

## **Report Structure**

The script generates CSV files for each category of checks. Each file contains the following columns:

- **Check**: The name of the compliance check.
- **Compliance**: Whether the check is Met or Not Met.
- **Recommendation**: Recommendations for resolving non-compliant configurations.

### **Example CSV Output:**

| Check                     | Compliance | Recommendation                                      |
|---------------------------|------------|----------------------------------------------------|
| Enforce password history  | Met        | Ensure the policy is set to 24 or more passwords.  |
| Maximum password age      | Not Met    | Ensure the policy is set to 365 or fewer days.    |

---

## **Categories of Checks**

The tool performs checks for the following categories:

- Password Policy
- Account Lockout Policy
- User Rights Assignment
- Security Options
- Windows Defender Firewall
- Windows Update
- Windows Ink Workspace
- Windows Installer
- Windows Logon Options
- Windows PowerShell
- WinRM Client/Service
- Windows Sandbox
- Windows Security
- Notifications
- Internet Communication Settings
- Attachment Manager
- Cloud Content

---

## **Customization**

You can add or modify checks by editing the PowerShell script. Each check is defined as a hashtable with the following keys:

- **Name**: The name of the check.
- **Value**: The current value of the setting.
- **Type**: Whether the check is Automated or Manual.
- **ExpectedValue**: The expected value for compliance.
- **Recommendation**: Recommendations for resolving non-compliant configurations.

### **Example:**

```powershell
@{ Name = "Enforce password history"; Value = 24; Type = "Automated"; ExpectedValue = 24; Recommendation = "Ensure the policy is set to 24 or more passwords." }
```

---

## **Contributing**

Contributions are welcome! If you'd like to add new checks, improve the script, or fix issues, please follow these steps:

1. Fork the repository.
2. Create a new branch for your changes:

   ```bash
   git checkout -b feature/your-feature-name
   ```

3. Commit your changes:

   ```bash
   git commit -m "Add your commit message here"
   ```

4. Push your changes to the branch:

   ```bash
   git push origin feature/your-feature-name
   ```

5. Open a pull request.

---

## **License**

This project is licensed under the MIT License. See the LICENSE file for details.

---

## **Acknowledgments**

- **CIS Benchmarks**: For providing comprehensive security guidelines.
- **PowerShell Community**: For creating powerful tools and modules.
