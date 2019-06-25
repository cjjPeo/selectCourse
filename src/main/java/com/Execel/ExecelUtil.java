package com.Execel;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.VerticalAlignment;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

public class ExecelUtil {
        /**
         * 创建 excel 表格
         *
         * @param list
         *            一条数据存一个map对象，map对象中存列和值得对应关系
         * @param destFile（目标文件）
         *            当然就是要存的文件信息,即表格保存的路径
         * @param headList
         *            很重要，它是列的展示，当然和数据的列要对应不然找不到对应的地方存储
         * @param message
         *            表格第一行的表头信息
         * @throws WriteException
         * @throws IOException
         */
        public static void CreateExcelFile(List<Map<String, Object>> list, File destFile, List<String> headList,
                                           String message) throws WriteException, IOException {
            // 获取传入 list 的大小，即有多少条数据
            int sizeAll = list.size();
            // 设置每页最大条数 65534 ，求出整数页 wholeNumber
            int wholeNumber = sizeAll / 65534;
            // 求出最后一页的条数
            int yu = sizeAll % 65534;
            // sheetSize:表示页数
            // flagList:循环参数，后面输出数据的时候用到
            int sheetSize = 1;
            int flagList = 1;
            // 判断要导出的数据需要存放在几页的 excel 表上
            if (sizeAll <= 65534) {
                sheetSize = 1;
            } else {
                if (yu > 0) {
                    sheetSize = wholeNumber + 1;
                } else {
                    sheetSize = wholeNumber;
                }
            }
            // 用 WritableWorkbook 创建一个可读写的工作簿
            WritableWorkbook book = null;
            // 以 destFile 为文件名来创建一个 workbook
            // createWorkbook（） : 参数 destFile 为 new File(D:/example.xls)
            book = Workbook.createWorkbook(destFile);
            //
            if (list.size() == 0) {
                // list 中没有数据，直接操作空的工作簿
                // 写进文档
                book.write();
            } else {
                for (int j = 0; j < sheetSize; j++) {
                    int index;
                    System.out.println("*****sheet（excle的左下角）" + j + "*****");
                    // 创建工作表( excel 中的 sheet 表)
                    // createSheet(String str,int n)
                    // String 型参数 str 为 sheet 表的名字，一般命名为"sheet0"或"sheet1"即可
                    // int 型参数 n 代表sheet号，0是第一页，1是第二页，依次类推，打开Excel表格在底端可以看到
                    WritableSheet sheet = book.createSheet(destFile.getName().replace(".xls", "") + j, j);

                    // ARIAL : 字体样式 【WritableFont.createFont("宋体") : 宋体字体的设置】
                    // WritableFont.TIMES
                    // 19 :字体大小
                    // WritableFont.BOLD, false 是判断是否为斜体,选择true时为斜体 ,默认为 false
                    WritableFont BoldFont = new WritableFont(WritableFont.createFont("宋体"), 18);
                    WritableCellFormat wcf_center = new WritableCellFormat(BoldFont);
                    wcf_center.setBorder(Border.ALL, BorderLineStyle.THIN); // 线条
                    wcf_center.setVerticalAlignment(VerticalAlignment.CENTRE); // 文字垂直对齐
                    wcf_center.setAlignment(Alignment.CENTRE); // 文字水平对齐
                    wcf_center.setWrap(false); // 文字是否换行
                    // wcf_center.setBackground(Colour.LIGHT_GREEN);// 单元格背景颜色
                    for (int i = 0; i < headList.size() + 1; i++) {
                        sheet.setColumnView(i, 20);// 设置第i列的宽度
                    }
                    // 合并首行，设置首行信息
                    // Label():第一个参数表示第几列，第二个参数表示第几行
                    // Label(0, 0, message,wcf_center):表示第0列第0行
                    // message:填入表格的信息
                    // wcf_center:表格样式
                    sheet.mergeCells(0, 0, headList.size() - 1, 0);
                    sheet.addCell(new Label(0, 0, message, wcf_center));

                    // 输出列名
                    index = 0;
                    for (String name : headList) {
                        // 上面合并了首行，所有这里在第二行开始输出列名
                        sheet.addCell(new Label(index, 1, name, wcf_center));
                        index++;
                    }

                    // 输出数据
                    // i:表示输出的数据为第 i 条
                    // t:表示在 excle 中的第 t+1 行输出数据
                    int i = 0;
                    int t = 2;
                    // flagList 初始值为1，作为循环变量
                    // 当 flagList 大于需要输出的数据条数时，则终止循环
                    while (flagList <= list.size()) {
                        index = 0;
                        if (i < 65534) {
                            for (String name : headList) {
                                sheet.addCell(new Label(index, t, list.get(flagList - 1).get(name) + "", wcf_center));
                                index++;
                            }
                            i++;
                            t++;
                            flagList++;
                        } else {
                            break;
                        }
                    }
                }
            }
            // 写入文档
            book.write();
            if (book != null) {
                // 关闭Excel工作簿对象
                book.close();
            }
        }

        /**
         * 调用浏览器接口进行文件下载
         *
         * @param filepath
         *            文件路径
         * @param response
         */
        public static void send(String filepath, HttpServletResponse response) {
            try {
                File file = new File(filepath);// filepath 是文件地址
                String filename = file.getName();// 获取日志文件名称
                InputStream fis = new BufferedInputStream(new FileInputStream(filepath));
                byte[] buffer = new byte[fis.available()];
                fis.read(buffer);
                fis.close();
                response.reset();
                // 先去掉文件名称中的空格,然后转换编码格式为utf-8,保证不出现乱码,这个文件名称用于浏览器的下载框中自动显示的文件名
                response.addHeader("Content-Disposition",
                        "attachment;filename=" + new String(filename.replaceAll(" ", "").getBytes("utf-8"), "iso8859-1"));
                response.addHeader("Content-Length", "" + file.length());
                OutputStream os = new BufferedOutputStream(response.getOutputStream());
                response.setContentType("application/octet-stream");
                os.write(buffer);// 输出文件
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        /**
         * 删除单个文件
         *
         * @param sPath
         *            被删除文件的文件名
         * @return 单个文件删除成功返回true，否则返回false
         */
        public static boolean deleteFile(String sPath) {
            boolean flag = false;
            File file = new File(sPath);
            // 路径为文件且不为空则进行删除
            if (file.isFile() && file.exists()) {
                file.delete();
                flag = true;
            }
            return flag;
        }
    }
