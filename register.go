package controller

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"

	"../repository"
	"../service"
	tokens "../token"
	"github.com/360EntSecGroup-Skylar/excelize"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

type Register struct {
	DB *gorm.DB
}

func NewRegister(db *gorm.DB) *Register {
	return &Register{
		DB: db,
	}
}

func PrepareAndReturnExcel() *excelize.File {
	f := excelize.NewFile()
	f.SetCellValue("Sheet1", "A1", "Username")
	f.SetCellValue("Sheet1", "A2", "Cemang")
	f.SetCellValue("Sheet1", "B1", "Location")
	f.SetCellValue("Sheet1", "B2", "CCC")
	f.SetCellValue("Sheet1", "C1", "Occupation")
	f.SetCellValue("Sheet1", "C2", "VVV")
	return f
}

func downloadExcel(w http.ResponseWriter, r *http.Request) {
	// Get the Excel file with the user input data
	file := PrepareAndReturnExcel()

	// Set the headers necessary to get browsers to interpret the downloadable file
	w.Header().Set("Content-Type", "application/octet-stream")
	w.Header().Set("Content-Disposition", "attachment; filename=userInputData.xlsx")
	w.Header().Set("File-Name", "userInputData.xlsx")
	w.Header().Set("Content-Transfer-Encoding", "binary")
	w.Header().Set("Expires", "0")
	file.Write(w)
}

func (ctrlReg *Register) CheckHandPhoneNumber(c *gin.Context) {
	//nama := c.PostForm("nama")
	// Input Tipe File Single
	/*
		file, err := c.FormFile("file")

		if err != nil {
			c.String(http.StatusBadRequest, fmt.Sprintf("err: %s", err.Error()))
			return
		}

		// Set Folder untuk menyimpan filenya
		path := "file_doc/" + file.Filename
		if err := c.SaveUploadedFile(file, path); err != nil {
			c.String(http.StatusBadRequest, fmt.Sprintf("err: %s", err.Error()))
			return
		}
	*/
	//c.PostForm("hpNumber")
	//INPUT TYPE FILE MULTI
	form, err := c.MultipartForm()
	if err != nil {
		c.String(http.StatusBadRequest, fmt.Sprintf("err: %s", err.Error()))
		return
	}
	// Files
	files := form.File["files"]
	fmt.Println("form")
	fmt.Println(form)
	// For range
	for _, file := range files {
		path := "file_doc/" + file.Filename
		if err := c.SaveUploadedFile(file, path); err != nil {
			c.String(http.StatusBadRequest, fmt.Sprintf("err: %s", err.Error()))
			return
		}
	}

	/*
		file := PrepareAndReturnExcel()

			err := file.SaveAs("./xlsx/Book1.xlsx")
			if err != nil {
				fmt.Println(err)
			}


		// Set the headers necessary to get browsers to interpret the downloadable file
		c.Header("Content-Type", "application/octet-stream")
		c.Header("Content-Disposition", "attachment; filename=userInputData.xlsx")
		c.Header("File-Name", "userInputData.xlsx")
		c.Header("Content-Transfer-Encoding", "binary")
		c.Header("Expires", "0")
		file.Write(c.Writer)
	*/

	n_ank_jk_kwn_akta_7 := map[string]interface{}{"jk": []interface{}{
		map[string]interface{}{"c": "ccc", "v": "ccc_vvv"},
		map[string]interface{}{"f": []map[string]interface{}{map[string]interface{}{"_f": "fff"}, map[string]interface{}{"_f": "fff"}}},
		map[string]interface{}{"fz": []interface{}{map[string]interface{}{"_f": "fff"}}},
	}}
	//ERROR
	fmt.Println(n_ank_jk_kwn_akta_7["jk"][1].(map[string]interface{})["f"].([]map[string]interface{})[0]["_f"])
	//NOT ERROR
	fmt.Println(n_ank_jk_kwn_akta_7["jk"].([]interface{})[1].(map[string]interface{})["f"].([]map[string]interface{})[0]["_f"])

	n_ank_jk_kwn_akta := map[string]interface{}{"jk": map[string]interface{}{"c": "ccc"}}
	fmt.Println(n_ank_jk_kwn_akta["jk"].(map[string]interface{})["c"])
	n_ank_jk_kwn_akta_1 := map[string][]interface{}{"jk": []interface{}{
		map[string]interface{}{"c": "ccc", "v": "ccc_vvv"},
		map[string]interface{}{"f": []map[string]interface{}{map[string]interface{}{"_f": "fff"}, map[string]interface{}{"_f": "fff"}}},
		map[string]interface{}{"fz": []interface{}{map[string]interface{}{"_f": "fff"}}},
	}}
	fmt.Println(n_ank_jk_kwn_akta_1["jk"][1].(map[string]interface{})["f"].([]map[string]interface{})[0]["_f"])
	fmt.Println(n_ank_jk_kwn_akta_1["jk"][2].(map[string]interface{})["fz"].([]interface{})[0].(map[string]interface{})["_f"])
	n_ank_jk_kwn_akta_3 := map[string]interface{}{"jk": []interface{}{
		map[string]interface{}{"c": "ccc", "v": "ccc_3"},
	}}
	fmt.Println(n_ank_jk_kwn_akta_3["jk"].([]interface{})[0].(map[string]interface{})["v"])
	n_ank_jk_kwn_akta_5 := map[string][]interface{}{"jk": []interface{}{
		map[string]interface{}{"c": "ccc", "v": "ccc_vvv"},
		map[string][]map[string]interface{}{"f": []map[string]interface{}{map[string]interface{}{"_f": "fff"}}},
	}}
	fmt.Println(n_ank_jk_kwn_akta_5["jk"][1].(map[string][]map[string]interface{})["f"][0]["_f"])
	fz := map[string]interface{}{}
	fc := map[string]interface{}{}
	fcv := map[string]interface{}{}
	fmt.Println(fz)
	//json.Unmarshal(b, &f)
	json.NewDecoder(c.Request.Body).Decode(&fc)
	fmt.Println(fc)
	_cv, _ := json.Marshal(fc)
	fmt.Println(string(_cv))
	bytesc, _ := ioutil.ReadAll(c.Request.Body)
	fmt.Println("string(bytes)" + string(bytesc))
	json.Unmarshal(bytesc, &fz)
	//fmt.Println(fc.(map[string]interface{})["hpNumber"])
	_c, _ := json.Marshal(fz)
	fmt.Println(_c)

	hp := c.Request.FormValue("hpNumber")

	_ok := c.Request.FormValue("ok")
	_cvv, _ := json.Marshal(_ok)
	fmt.Println(_cvv)
	json.Unmarshal(_cvv, &fcv)
	fmt.Println("OKEEEEEEEEEEEEE" + _ok)
	fmt.Println(fcv)
	//reg.Repo = repository.Register{Service: service.Register{HpNumber: hp}}
	reg := repository.Register{Service: service.Register{HpNumber: hp}}
	//reg := repository.NewRegister(service.NewRegister("", "", "", nil))

	if r := reg.CheckHandPhoneNumber(ctrlReg.DB); r.Err == nil && r.Code != 3 {
		c.JSON(http.StatusOK, gin.H{"code": 1, "r": true, "msg": r.Msg})
	} else {
		c.JSON(http.StatusOK, gin.H{"code": 3, "r": false, "msg": r.Msg})
	}

}

func (ctrlReg *Register) SendOtp(c *gin.Context) {
	hp := c.Request.FormValue("hpNumber")
	reg := repository.Register{Service: service.Register{HpNumber: hp}}
	if r := reg.SendOtp(ctrlReg.DB); r.Err == nil {
		if strArr := strings.Split(r.Msg, "&"); strArr[0] == "Status=1" {
			c.JSON(http.StatusOK, gin.H{"code": 1, "r": true, "msg": r.Msg})
		} else {
			c.JSON(http.StatusOK, gin.H{"code": 3, "r": false, "msg": "Tidak Dapat Mengirim OTP (" + r.Msg + "), Silahkan Diulangi"})
		}
	} else {
		c.JSON(http.StatusOK, gin.H{"code": 3, "r": false, "msg": "Tidak Dapat Mengirim OTP, Ada Kendala Service Operator OTP"})
	}
}

func (ctrlReg *Register) VerifyOtp(c *gin.Context) {
	hp := c.Request.FormValue("hpNumber")
	otp := c.Request.FormValue("otp")
	reg := repository.Register{Service: service.Register{HpNumber: hp, Otp: otp}}
	if r := reg.VerifyOtp(ctrlReg.DB); r.Err == nil {
		c.JSON(http.StatusOK, gin.H{"code": 1, "r": true, "msg": r.Msg})
	} else {
		c.JSON(http.StatusOK, gin.H{"code": 3, "r": false, "msg": r.Msg})
	}
}

func (ctrlReg *Register) SetPin(c *gin.Context) {
	hp := c.Request.FormValue("hpNumber")
	otp := c.Request.FormValue("otp")
	pin := c.Request.FormValue("pin")
	reg := repository.Register{Service: service.Register{HpNumber: hp, Pin: pin, Otp: otp, Token: tokens.Token{HpNumber: hp, Pin: pin}}}
	if r := reg.SetPin(ctrlReg.DB); r.Err == nil {
		c.JSON(http.StatusOK, gin.H{"code": 1, "r": true, "msg": r.Msg, "token": r.R})
	} else {
		c.JSON(http.StatusOK, gin.H{"code": 3, "r": false, "msg": r.Msg})
	}
}
