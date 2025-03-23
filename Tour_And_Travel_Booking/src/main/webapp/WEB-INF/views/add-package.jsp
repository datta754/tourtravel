<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Tour Package</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Arial', sans-serif;
    }

    body {
        background: #f5f7fa;
        padding: 40px 20px;
        min-height: 100vh;
    }

    .package-container {
        max-width: 800px;
        margin: 0 auto;
        background: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
    }

    .form-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .form-header h2 {
        color: #003b95;
        font-size: 28px;
        margin-bottom: 10px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-row {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
    }

    .form-col {
        flex: 1;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: #333;
        font-weight: bold;
        font-size: 14px;
    }

    input, textarea, select {
        width: 100%;
        padding: 12px;
        border: 2px solid #e0e0e0;
        border-radius: 6px;
        font-size: 14px;
        transition: border-color 0.3s;
    }

    input:focus, textarea:focus, select:focus {
        outline: none;
        border-color: #003b95;
    }

    .image-upload {
        border: 2px dashed #e0e0e0;
        padding: 20px;
        text-align: center;
        border-radius: 6px;
        cursor: pointer;
        transition: border-color 0.3s;
        position: relative;
        min-height: 150px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .image-upload:hover {
        border-color: #003b95;
    }

    #imagePreview {
        max-width: 100%;
        max-height: 300px;
        display: none;
        border-radius: 4px;
        margin-top: 15px;
    }

    .preview-container {
        position: relative;
    }

    .remove-image {
        position: absolute;
        top: 10px;
        right: 10px;
        background: #ff4444;
        color: white;
        border: none;
        border-radius: 50%;
        width: 24px;
        height: 24px;
        cursor: pointer;
        display: none;
    }

    .button-group {
        margin-top: 30px;
        display: flex;
        gap: 15px;
        justify-content: flex-end;
    }

    .btn {
        padding: 12px 30px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
        transition: opacity 0.3s;
    }

    .btn-primary {
        background-color: #003b95;
        color: white;
    }

    .btn-secondary {
        background-color: #e0e0e0;
        color: #333;
    }

    .error-message {
        color: #dc3545;
        font-size: 12px;
        margin-top: 5px;
    }

    @media (max-width: 768px) {
        .form-row {
            flex-direction: column;
            gap: 0;
        }
        
        .package-container {
            padding: 25px;
        }
    }
</style>
</head>
<body>
    <div class="package-container">
        <div class="form-header">
            <h2>Create New Tour Package</h2>
            <p>Fill in the details to add a new travel package</p>
        </div>

        <form action="addpackages" method="post" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="packageName">Package Name <span class="required">*</span></label>
                        <input type="text" id="packageName" name="packageName" required>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="destination">Destination <span class="required">*</span></label>
                        <input type="text" id="destination" name="destination" required>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="durationDays">Duration (Days) <span class="required">*</span></label>
                        <input type="number" id="durationDays" min="1" name="durationDays" required>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="durationNights">Duration (Nights) <span class="required">*</span></label>
                        <input type="number" id="durationNights" min="0" name="durationNights" required>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="price">Price per Person ($) <span class="required">*</span></label>
                        <input type="number" id="price" min="0" step="0.01" name="price" required>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="maxPeople">Max People <span class="required">*</span></label>
                        <input type="number" id="maxPeople" min="1" name="maxPeople" required>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Package Description <span class="required">*</span></label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="startDate">Start Date <span class="required">*</span></label>
                        <input type="date" id="startDate" name="startDate" required 
                               pattern="\d{4}-\d{2}-\d{2}">
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="endDate">End Date <span class="required">*</span></label>
                        <input type="date" id="endDate" name="endDate" required 
                               pattern="\d{4}-\d{2}-\d{2}">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>Featured Image <span class="required">*</span></label>
                <div class="preview-container">
                    <div class="image-upload" onclick="document.getElementById('fileInput').click()">
                        <div id="uploadText">Click to upload image or drag and drop</div>
                        <input type="file" id="fileInput" accept="image/*" 
                               style="display: none;" name="imageFile" required>
                        <img id="imagePreview" alt="Preview">
                    </div>
                    <button type="button" class="remove-image" onclick="removeImage()">×</button>
                </div>
            </div>

            <div class="form-group">
                <label>Inclusions</label>
                <div class="checkbox-group">
                    <div class="checkbox-item">
                        <input type="checkbox" id="meals" name="inclusions" value="Meals">
                        <label for="meals">Meals</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="accomodation" name="inclusions" value="Accommodation">
                        <label for="accomodation">Accommodation</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="transfers" name="inclusions" value="Transfers">
                        <label for="transfers">Transfers</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="guide" name="inclusions" value="Tour Guide">
                        <label for="guide">Tour Guide</label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="exclusions">Exclusions</label>
                <textarea id="exclusions" name="exclusions" rows="3"></textarea>
            </div>

            <div class="button-group">
                <button type="reset" class="btn btn-secondary">Clear Form</button>
                <button type="submit" class="btn btn-primary">Create Package</button>
            </div>
        </form>
    </div>

    <script>
        const fileInput = document.getElementById('fileInput');
        const imagePreview = document.getElementById('imagePreview');
        const uploadText = document.getElementById('uploadText');
        const removeBtn = document.querySelector('.remove-image');

        fileInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.style.display = 'block';
                    imagePreview.src = e.target.result;
                    uploadText.style.display = 'none';
                    removeBtn.style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
        });

        function removeImage() {
            fileInput.value = '';
            imagePreview.src = '';
            imagePreview.style.display = 'none';
            uploadText.style.display = 'block';
            removeBtn.style.display = 'none';
        }

        // Drag and drop functionality
        const dropZone = document.querySelector('.image-upload');

        dropZone.addEventListener('dragover', (e) => {
            e.preventDefault();
            dropZone.style.borderColor = '#003b95';
        });

        dropZone.addEventListener('dragleave', () => {
            dropZone.style.borderColor = '#e0e0e0';
        });

        dropZone.addEventListener('drop', (e) => {
            e.preventDefault();
            dropZone.style.borderColor = '#e0e0e0';
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                fileInput.files = files;
                fileInput.dispatchEvent(new Event('change'));
            }
        });
    </script>
</body>
</html>