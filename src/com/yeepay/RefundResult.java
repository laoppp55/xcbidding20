package com.yeepay;

public class RefundResult
{
  private String r0_Cmd;
  private String r1_Code;
  private String r2_TrxId;
  private String r3_Amt;
  private String r4_Cur;
  private String hmac;

  public String getR0_Cmd()
  {
    return this.r0_Cmd;
  }

  public void setR0_Cmd(String cmd) {
    this.r0_Cmd = cmd;
  }

  public String getR1_Code() {
    return this.r1_Code;
  }

  public void setR1_Code(String code) {
    this.r1_Code = code;
  }

  public String getR2_TrxId() {
    return this.r2_TrxId;
  }

  public void setR2_TrxId(String trxId) {
    this.r2_TrxId = trxId;
  }

  public String getR3_Amt() {
    return this.r3_Amt;
  }

  public void setR3_Amt(String amt) {
    this.r3_Amt = amt;
  }

  public String getR4_Cur() {
    return this.r4_Cur;
  }

  public void setR4_Cur(String cur) {
    this.r4_Cur = cur;
  }

  public String getHmac() {
    return this.hmac;
  }

  public void setHmac(String hmac) {
    this.hmac = hmac;
  }
}